import 'dart:io';

import 'package:appwrite_workbench/core/appwrite_client.dart';
import 'package:appwrite_workbench/core/appwrite_workbench_code.dart';
import 'package:appwrite_workbench/models/appwrite_workbench_exception.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/function_services/function_service.dart';
import 'package:appwrite_workbench/services/local_storage_service.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:path/path.dart' as path;
import 'package:dart_appwrite/models.dart' as appwrite_models;
import 'package:logging/logging.dart';
import 'package:appwrite_workbench/core/runtime_enum_extensions.dart';
import 'package:process_run/process_run.dart';

class FunctionApiService implements FunctionService<FunctionApi> {
  FunctionApiService({required this.client});
  static final Logger _logger = Logger('FunctionJsonService');

  final AppwriteClient client;

  @override
  Future<List<appwrite_models.Runtime>> listRuntime(
      {List<String>? queries}) async {
    try {
      _logger.info('Getting runtimes');
      final response = await client.functions.listRuntimes();
      _logger.info('Got runtimes: ${response.runtimes}');
      return response.runtimes;
    } on AppwriteException catch (e, stackTrace) {
      _logger.severe('Error getting runtimes: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: e.message ?? 'Error getting runtimes',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    } catch (e, stackTrace) {
      _logger.severe('Error getting runtimes: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error getting runtimes',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  @override
  Future<FunctionApi> createFunction({
    required String id,
    required String name,
    required String runtime,
    required ProjectWorkbench project,
  }) async {
    try {
      _logger.info('Creating function');

      final base = LocalStorageService.base;

      final responseData = await client.functions.create(
        functionId: id,
        name: name,
        runtime: runtime.toRuntime(),
      );

      _logger.info('Function created: ${responseData.$id}');
      final functionsDirectory = await _getFunctionsDirectory(base);
      final functionsDirectoryDedicated = await _getFunctionDedicateDirectory(
        functionsDir: functionsDirectory,
        functionName: name,
      );

      // Git commands for sparse checkout
      String gitInitCommands =
          'git clone -b v3 --single-branch --depth 1 --sparse https://github.com/appwrite/functions-starter .';
      String gitPullCommands = 'git sparse-checkout add $runtime';

      // Use CMD for Windows
      if (Platform.isWindows) {
        gitInitCommands = 'cmd /c "$gitInitCommands"';
        gitPullCommands = 'cmd /c "$gitPullCommands"';
      }
      final shell = Shell(workingDirectory: functionsDirectoryDedicated.path);

      _logger.info('Running git commands');
      await shell.run(gitInitCommands);
      _logger.finest('Running git  commands');
      _logger.info('Running git pull commands');
      await shell.run(gitPullCommands);
      _logger.finest('Running git pull commands');

      // Clean up the .git directory
      final Directory gitDir = Directory(path.join(
        functionsDirectoryDedicated.path,
        '.git',
      ));
      if (gitDir.existsSync()) {
        gitDir.deleteSync(recursive: true);
      }

      // Copy files from the runtime-specific folder to the main function directory
      _copyRecursiveSync(
        path.join(functionsDirectoryDedicated.path, runtime),
        functionsDirectoryDedicated.path,
      );

      // Remove the now-empty runtime-specific folder
      final Directory runtimeDir = Directory(
        path.join(
          functionsDirectoryDedicated.path,
          runtime,
        ),
      );

      if (runtimeDir.existsSync()) {
        _logger.info('Deleting runtime directory');
        runtimeDir.deleteSync(recursive: true);
        _logger.finest('Runtime directory deleted');
      }

      final response = FunctionApi.fromJson(responseData);
      response.projects.add(project as ProjectApi);
      LocalStorageService.isar.writeTxn(() async {
        await LocalStorageService.isar.functionApis.put(response);
        await response.projects.save();
      });

      return response;
    } on AppwriteException catch (e, stackTrace) {
      _logger.severe('Error creating function: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: e.message ?? 'Error creating function',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    } catch (e, stackTrace) {
      _logger.severe('Error creating function: $e', e, stackTrace);

      // Handle specialized errors with recommended actions
      if (e.toString().contains('error: unknown option')) {
        throw Exception(
            '${e.toString()} \n\nSuggestion: Try updating your git to the latest version, then try running this command again.');
      } else if (e.toString().contains(
              'is not recognized as an internal or external command,') ||
          e.toString().contains('command not found')) {
        throw Exception(
            '${e.toString()} \n\nSuggestion: It appears that git is not installed, try installing git then try running this command again.');
      }

      throw AppwriteWorkbenchException(
          message: 'Error creating function',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

//Function to copy files recursively
  void _copyRecursiveSync(String src, String dest) {
    _logger.info('Copying files recursively');
    final Directory srcDir = Directory(src);
    final Directory destDir = Directory(dest);

    if (srcDir.existsSync()) {
      _logger.finest('Source directory exists');
      if (!destDir.existsSync()) {
        _logger.info('Creating destination directory');
        destDir.createSync();
      }

      _logger.finest('Listing source directory');
      srcDir.listSync(recursive: false).forEach((entity) {
        if (entity is Directory) {
          final String newDir = path.join(dest, path.basename(entity.path));
          _copyRecursiveSync(entity.path, newDir);
        } else if (entity is File) {
          entity.copySync(path.join(dest, path.basename(entity.path)));
        }
      });
      _logger.finest('Files copied');
    } else {
      _logger.severe('Source directory does not exist: $src');
      throw AppwriteWorkbenchException(
          message: 'Source directory does not exist',
          code: AppwriteWorkbenchExceptionCode.notFound,
          stackTrace: StackTrace.current);
    }
  }

  Future<Directory> _getFunctionsDirectory(String base) async {
    _logger.info('Getting functions directory');
    final functionsPath = path.join(base, 'functions');
    final directory = Directory(functionsPath);
    _logger.finest('Directory: ${directory.path}');
    if (!(await directory.exists())) {
      _logger.info('Creating functions directory');
      await directory.create(recursive: true);
    }
    return directory;
  }

  Future<Directory> _getFunctionDedicateDirectory({
    required Directory functionsDir,
    required String functionName,
  }) async {
    _logger.info('Getting function directory');
    final functionNamePath = path.join(functionsDir.path, functionName);
    final directory = Directory(functionNamePath);
    _logger.finest('Directory: ${directory.path}');
    if (!(await directory.exists())) {
      _logger.info('Creating function directory');
      await directory.create(recursive: true);
      return directory;
    } else {
      throw AppwriteWorkbenchException(
          message: 'Function already exists',
          code: AppwriteWorkbenchExceptionCode.alreadyExists,
          stackTrace: StackTrace.current);
    }
  }
}
