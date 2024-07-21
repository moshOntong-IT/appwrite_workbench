import 'dart:convert';
import 'dart:io';

import 'package:appwrite_workbench/core/appwrite_workbench_code.dart';
import 'package:appwrite_workbench/models/appwrite_workbench_exception.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/local_storage_service.dart';
import 'package:appwrite_workbench/services/project_services/project_service.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:process_run/process_run.dart';

class ProjectJsonService implements ProjectService<ProjectJson> {
  // Private constructor

  static final Logger _logger = Logger('ProjectJsonService');

  Future<void> createProjectApi({
    required ProjectApi project,
  }) async {
    try {
      final isExisting = await LocalStorageService.isar.projectApis
          .filter()
          .projectIdEqualTo(
            project.projectId,
          )
          .findAll();

      if (isExisting.isNotEmpty) {
        throw AppwriteWorkbenchException(
            message: 'Project already exists',
            code: AppwriteWorkbenchExceptionCode.alreadyExists,
            stackTrace: StackTrace.current);
      }
      await LocalStorageService.isar.writeTxn(() async {
        await LocalStorageService.isar.projectApis.put(
          project,
        );
        await LocalStorageService.instance.addKey(
          projectId: project.projectId,
          key: project.apiKey,
        );
      });
    } catch (e, stackTrace) {
      _logger.severe('Error creating project: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error creating project',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  @override
  Future<void> removeProject(ProjectJson project) async {
    await LocalStorageService.isar.writeTxn(() async {
      await LocalStorageService.isar.projectJsons.delete(
        project.id,
      );
    });
  }

  @override
  Future<ProjectJson> createProject(ProjectJson project) async {
    try {
      final file = File(project.path);
      if (!await file.exists()) {
        throw AppwriteWorkbenchException(
          message: 'File not found',
          code: AppwriteWorkbenchExceptionCode.notFound,
        );
      }

      final contents = await file.readAsString();
      final jsonContent = jsonDecode(contents);

      // Check for projectName in the JSON
      final projectName =
          (jsonContent['projectName'] as String?)?.isEmpty ?? true
              ? '[No Project Name]'
              : jsonContent['projectName'] as String;
      final projectFinal = project..name = projectName;
      await LocalStorageService.isar.writeTxn(() async {
        await LocalStorageService.isar.projectJsons.put(projectFinal);
      });

      return project;
    } catch (e, stackTrace) {
      _logger.severe('Error creating project: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
        message: 'Error creating project',
        code: AppwriteWorkbenchExceptionCode.unknown,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<List<ProjectJson>> getProjects() async {
    try {
      final projects =
          await LocalStorageService.isar.projectJsons.where().findAll();
      return projects;
    } catch (e, stackTrace) {
      _logger.severe('Error getting projects: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error getting projects',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  @override
  Stream<List<ProjectJson>> watchProject() {
    return LocalStorageService.isar.projectJsons.where().watch();
  }

  @override
  Future<void> openDirectory(ProjectJson project) async {
    _logger.info('Opening directory: ${project.path}');
    try {
      final directory = p.dirname(project.path);
      final dir = Directory(directory);
      if (!await dir.exists()) {
        throw AppwriteWorkbenchException(
          message: 'Directory not found',
          code: AppwriteWorkbenchExceptionCode.notFound,
        );
      }

      final shell = Shell();
      if (Platform.isWindows) {
        await shell.run('explorer $directory');
      } else if (Platform.isMacOS) {
        await shell.run('open "$directory"');
      } else if (Platform.isLinux) {
        await shell.run('xdg-open "$directory"');
      } else {
        throw AppwriteWorkbenchException(
            message: 'Unsupported platform',
            code: AppwriteWorkbenchExceptionCode.unknown);
      }
    } on ShellException catch (e, stackTrace) {
      _logger.severe(e.result?.stderr);
      _logger.severe('Error opening directory: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error opening directory',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    } catch (e, stackTrace) {
      _logger.severe('Error opening directory: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error opening directory',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  @override
  Future<void> openTerminal(ProjectJson project) async {
    _logger.info('Opening terminal: ${project.path}');
    try {
      final directory = p.dirname(project.path);
      final dir = Directory(directory);
      if (!await dir.exists()) {
        throw AppwriteWorkbenchException(
          message: 'Directory not found',
          code: AppwriteWorkbenchExceptionCode.notFound,
        );
      }

      final shell = Shell();
      if (Platform.isWindows) {
        await shell.run('cmd /c start cmd.exe /K cd /d $directory');
      } else if (Platform.isMacOS) {
        await shell.run('open -a Terminal "$directory"');
      } else if (Platform.isLinux) {
        await shell.run('x-terminal-emulator --working-directory="$directory"');
      } else {
        throw AppwriteWorkbenchException(
            message: 'Unsupported platform',
            code: AppwriteWorkbenchExceptionCode.unknown);
      }
    } catch (e, stackTrace) {
      _logger.severe('Error opening terminal: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error opening terminal',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }
}
