import 'dart:io';

import 'package:appwrite_workbench/core/appwrite_client.dart';
import 'package:appwrite_workbench/core/appwrite_workbench_code.dart';
import 'package:appwrite_workbench/models/appwrite_workbench_exception.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/function_services/function_service.dart';
import 'package:appwrite_workbench/services/local_storage_service.dart';
import 'package:dart_appwrite/dart_appwrite.dart' as appwrite;
import 'package:isar/isar.dart';
import 'package:path/path.dart' as path;
import 'package:dart_appwrite/models.dart' as appwrite_models;
import 'package:logging/logging.dart';
import 'package:appwrite_workbench/core/runtime_enum_extensions.dart';
import 'package:process_run/process_run.dart';

class FunctionApiService implements FunctionService<FunctionApi> {
  FunctionApiService({required this.client});
  static final Logger _logger = Logger('FunctionApiService');

  final AppwriteClient client;

  @override
  Future<List<appwrite_models.Runtime>> listRuntime(
      {List<String>? queries}) async {
    try {
      _logger.info('Getting runtimes');
      final response = await client.functions.listRuntimes();
      _logger.info('Got runtimes: ${response.runtimes}');
      return response.runtimes;
    } on appwrite.AppwriteException catch (e, stackTrace) {
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
    String? name,
    required String runtime,
    required ProjectWorkbench project,
  }) async {
    try {
      final effectiveProject = project as ProjectApi;
      _logger.info('Creating function');

      final effectiveName = name ?? 'Function_$id';
      final responseData = await client.functions.create(
        functionId: id,
        name: effectiveName,
        runtime: runtime.toRuntime(),
        entrypoint: getEntrypoint(runtime),
        commands: getInstallCommand(runtime),
      );

      _logger.info('Function created: ${responseData.$id}');
      final functionsDirectory = await _getFunctionsDirectory();
      final functionsDirectoryDedicated = await _getFunctionDedicateDirectory(
        functionsDir: functionsDirectory,
        functionName: responseData.$id,
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
      try {
        final shell = Shell(workingDirectory: functionsDirectoryDedicated.path);

        _logger.info('Running git commands');
        await shell.run(gitInitCommands);
        _logger.finest('Running git  commands');
        _logger.info('Running git pull commands');
        await shell.run(gitPullCommands);
        _logger.finest('Running git pull commands');
      } on ShellException catch (e, stackTrace) {
        _logger.severe('Error running git commands: $e', e, stackTrace);
        throw AppwriteWorkbenchException(
            message: e.message,
            code: AppwriteWorkbenchExceptionCode.unknown,
            stackTrace: stackTrace);
      } catch (e, stackTrace) {
        _logger.severe('Error running git commands: $e', e, stackTrace);
        // Handle specialized errors with recommended actions
        if (e.toString().contains('error: unknown option')) {
          throw AppwriteWorkbenchException(
              message:
                  '${e.toString()} \n\nSuggestion: Try updating your git to the latest version, then try running this command again.',
              code: AppwriteWorkbenchExceptionCode.unknown,
              stackTrace: stackTrace);
        } else if (e.toString().contains(
                'is not recognized as an internal or external command,') ||
            e.toString().contains('command not found')) {
          throw AppwriteWorkbenchException(
              message:
                  '${e.toString()} \n\nSuggestion: Make sure you have git installed on your system and it is added to your PATH.',
              code: AppwriteWorkbenchExceptionCode.unknown,
              stackTrace: stackTrace);
        }
      }
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
        src: path.join(functionsDirectoryDedicated.path, runtime),
        dest: functionsDirectoryDedicated.path,
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

      final response = FunctionApi.fromJson(responseData)
        ..createdAt = DateTime.parse(responseData.$createdAt).toLocal()
        ..updatedAt = DateTime.parse(responseData.$updatedAt).toLocal();
      response.projects.add(effectiveProject);
      LocalStorageService.isar.writeTxn(() async {
        await LocalStorageService.isar.functionApis.put(response);
        await response.projects.save();
      });

      return response;
    } on appwrite.AppwriteException catch (e, stackTrace) {
      _logger.severe('Error creating function: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: e.message ?? 'Error creating function',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    } on AppwriteWorkbenchException catch (e, stackTrace) {
      _logger.severe('Error creating function: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: e.message,
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    } catch (e, stackTrace) {
      _logger.severe('Error creating function: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: e.toString(),
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

//Function to copy files recursively
  void _copyRecursiveSync({required String src, required String dest}) {
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
          _copyRecursiveSync(src: entity.path, dest: newDir);
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

  Future<Directory> _getFunctionsDirectory() async {
    _logger.info('Getting functions directory');
    final base = LocalStorageService.base;
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
      return directory;
    }
  }

  @override
  Future<List<FunctionApi>> listFunction({
    required ProjectWorkbench project,
  }) async {
    try {
      _logger.info('Getting functions');
      final functions =
          await LocalStorageService.isar.functionApis.filter().projects((q) {
        return q.idEqualTo(project.id);
      }).findAll();

      _logger.info('Got functions: $functions');
      return functions;
    } catch (e, stackTrace) {
      _logger.severe('Error getting functions: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error getting functions',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  @override
  Stream<List<FunctionApi>> watchFunctions(
      {required ProjectWorkbench project}) {
    return LocalStorageService.isar.functionApis.filter().projects((q) {
      return q.idEqualTo(project.id);
    }).watch();
  }

  @override
  Future<appwrite_models.Deployment> pushFunction({
    required String id,
    required ProjectWorkbench project,
  }) async {
    try {
      _logger.info('Creating deployment');
      final effectiveProject = project as ProjectApi;

      final functionsDirectory = await _getFunctionsDirectory();

      final function = await LocalStorageService.isar.functionApis
          .filter()
          .$idEqualTo(id)
          .projects((q) {
        return q.idEqualTo(effectiveProject.id);
      }).findFirst();

      if (function == null) {
        throw AppwriteWorkbenchException(
            message: 'Function not found',
            code: AppwriteWorkbenchExceptionCode.notFound,
            stackTrace: StackTrace.current);
      }
      final functionsDirectoryDedicated = await _getFunctionDedicateDirectory(
        functionsDir: functionsDirectory,
        functionName: function.$id,
      );

      _logger.info('Uploading metadata of this function');

      await client.functions.update(
        functionId: function.$id,
        name: function.name,
        runtime: function.runtime.toRuntime(),
        commands: function.commands,
        enabled: function.enabled,
        entrypoint: function.entrypoint,
        events: function.events,
        execute: function.execute,
        schedule: function.schedule,
        scopes: function.scopes,
        timeout: function.timeout,
        logging: function.logging,
        installationId: function.installationId,
        providerBranch: function.providerBranch,
        providerRepositoryId: function.providerRepositoryId,
        providerRootDirectory: function.providerRootDirectory,
        providerSilentMode: function.providerSilentMode,
      );

      await _pushVariables(
        function: function,
        project: effectiveProject,
      );

      _logger.fine('Function metadata uploaded');

      _logger.info('Zipping function folder into tar.gz');

      final tempFile = await _zipFunctionFolder(
        functionsDirectoryDedicated: functionsDirectoryDedicated,
      );

      _logger.info('Uploading deployment');

      final response = await client.functions.createDeployment(
        functionId: function.$id,
        code: appwrite.InputFile.fromPath(path: tempFile.path),
        activate: true,
      );

      _logger.info('Deployment created: ${response.$id}');

      _logger.info('Deleting temp file');
      tempFile.deleteSync();
      _logger.fine('Temp file deleted');

      await _getDeploymentLoop(
        deploymentId: response.$id,
        functionId: function.$id,
        onFailed: () {
          throw AppwriteWorkbenchException(
              message: 'Deployment failed',
              code: AppwriteWorkbenchExceptionCode.unknown,
              stackTrace: StackTrace.current);
        },
      );

      return response;
    } catch (e, stackTrace) {
      _logger.severe('Error creating deployment: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error creating deployment',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  @override
  Future<void> pullFunction({
    required String id,
    required ProjectWorkbench project,
    bool replace = false,
  }) async {
    try {
      _logger.info('Pulling function');

      final effectiveProject = project as ProjectApi;

      _logger.info('Getting function from Cloud');
      final cloudFunctionResponse = await client.functions.get(functionId: id);
      final cloudFunction = FunctionApi.fromJson(cloudFunctionResponse);
      _logger.info('Got function from Cloud: $cloudFunctionResponse');

      _logger.info('Updating function in Local');

      await LocalStorageService.isar.writeTxn(() async {
        final localFunction = await LocalStorageService.isar.functionApis
            .filter()
            .$idEqualTo(cloudFunction.$id)
            .projects((q) {
          return q.idEqualTo(effectiveProject.id);
        }).findFirst();

        if (localFunction == null) {
          await LocalStorageService.isar.functionApis.put(cloudFunction);
          cloudFunction.projects.add(effectiveProject);
          await cloudFunction.projects.save();
        } else {
          localFunction
            ..name = cloudFunction.name
            ..runtime = cloudFunction.runtime
            ..execute = cloudFunction.execute
            ..events = cloudFunction.events
            ..schedule = cloudFunction.schedule
            ..timeout = cloudFunction.timeout
            ..enabled = cloudFunction.enabled
            ..logging = cloudFunction.logging
            ..entrypoint = cloudFunction.entrypoint
            ..commands = cloudFunction.commands
            ..live = cloudFunction.live
            ..deployment = cloudFunction.deployment
            ..scopes = cloudFunction.scopes
            ..version = cloudFunction.version
            ..installationId = cloudFunction.installationId
            ..providerRepositoryId = cloudFunction.providerRepositoryId
            ..providerBranch = cloudFunction.providerBranch
            ..providerRootDirectory = cloudFunction.providerRootDirectory
            ..providerSilentMode = cloudFunction.providerSilentMode
            ..ignore = cloudFunction.ignore
            ..updatedAt = cloudFunction.updatedAt;
          await LocalStorageService.isar.functionApis.put(localFunction);
        }
      });

      await _pullVariables(
        function: cloudFunction,
        project: effectiveProject,
      );

      if (replace) {
        await _replaceFunction(
          function: cloudFunction,
          project: effectiveProject,
        );
      }

      _logger.info('Function updated in Local');
    } catch (e, stackTrace) {
      _logger.severe('Error pulling function: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error pulling function',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  Future<void> _getDeploymentLoop({
    required String deploymentId,
    required String functionId,
    required void Function() onFailed,
  }) async {
    try {
      var pollChecks = 0;
      while (true) {
        final deployment = await client.functions.getDeployment(
          functionId: functionId,
          deploymentId: deploymentId,
        );
        if (deployment.status == 'ready') {
          break;
        }
        if (deployment.status == 'failed') {
          onFailed();
          break;
        }

        pollChecks++;

        await Future.delayed(Duration(milliseconds: pollChecks * 1000));
      }
    } catch (e, stackTrace) {
      _logger.severe('Error getting deployment: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error getting deployment',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  Future<void> _replaceFunction({
    required FunctionApi function,
    required ProjectApi project,
  }) async {
    _logger.info('Replacing function');

    final functionsDirectory = await _getFunctionsDirectory();

    _logger.info('Getting the latest deployment');
    final latestDeployment = await client.functions
        .listDeployments(functionId: function.$id, queries: [
      appwrite.Query.orderDesc(r'$updatedAt'),
      appwrite.Query.limit(1),
    ]);

    if (latestDeployment.deployments.isEmpty) {
      throw AppwriteWorkbenchException(
          message: 'No deployment found',
          code: AppwriteWorkbenchExceptionCode.notFound,
          stackTrace: StackTrace.current);
    }

    final deployment = latestDeployment.deployments.first;
    _logger.info('Got latest deployment: ${deployment.$id}');
    _logger.info('Downloading deployment');
    final downloadedResponse = await client.functions.getDeploymentDownload(
      functionId: function.$id,
      deploymentId: deployment.$id,
    );
    final downloadedFile = File(path.join(
      functionsDirectory.path,
      '${function.name}-pull.tar.gz',
    ));
    await downloadedFile.writeAsBytes(downloadedResponse);
    await _pullCodeFolder(
      functionName: function.name,
      downloadedFile: downloadedFile,
      functionsDirectory: functionsDirectory,
    );

    // _logger.info('Extracting downloaded deployment');

    // final result = await Process.run(
    //   'tar',
    //   [
    //     '-xzf',
    //     downloadedFile.path,
    //     '-C',
    //     (functionsDirectory.path),
    //   ],
    // );

    // if (result.exitCode != 0) {}
    _logger.finest('Downloaded deployment extracted');

    final functionDirectoryDedicated = await _getFunctionDedicateDirectory(
      functionsDir: functionsDirectory,
      functionName: function.$id,
    );

    _logger.info('Cleaning all files in the function directory');

    if (functionDirectoryDedicated.existsSync()) {
      // List all entities in the directory
      for (var entity in functionDirectoryDedicated.listSync()) {
        try {
          if (entity is File) {
            entity.deleteSync();
          } else if (entity is Directory) {
            entity.deleteSync(recursive: true);
          }
        } catch (e) {
          _logger.warning('Failed to delete ${entity.path}: $e');
        }
      }
    }

    _logger.finest('All files in the function directory cleaned');
    _logger.info('Moving extracted files to the function directory');

    final extractedDirectory = Directory(
      path.join(
        functionsDirectory.path,
        '${function.name}-pull',
      ),
    );

    if (extractedDirectory.existsSync()) {
      // List all entities in the extracted directory
      for (var entity in extractedDirectory.listSync()) {
        final newPath = path.join(
            functionDirectoryDedicated.path, path.basename(entity.path));
        try {
          if (entity is File) {
            entity.renameSync(newPath);
          } else if (entity is Directory) {
            entity.renameSync(newPath);
          }
        } catch (e) {
          _logger.warning('Failed to move ${entity.path} to $newPath: $e');
        }
      }

      // Delete the extracted directory after moving its contents
      try {
        extractedDirectory.deleteSync(recursive: true);
      } catch (e) {
        _logger.warning('Failed to delete ${extractedDirectory.path}: $e');
      }
    }

    _logger.finest('Extracted files moved to the function directory');

    _logger.info('Deleting downloaded file');
    downloadedFile.deleteSync();

    _logger.fine('Downloaded file deleted');
  }

  Future<void> _pullVariables({
    required FunctionApi function,
    required ProjectApi project,
  }) async {
    try {
      _logger.info('Pulling variables');
      final response = await client.functions.listVariables(
        functionId: function.$id,
      );

      final variables = response.variables;

      await LocalStorageService.instance.setVars(
        projectId: project.projectId,
        functionId: function.$id,
        vars: variables,
      );
    } catch (e, stackTrace) {
      _logger.severe('Error pulling variables: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error pulling variables',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  Future<void> _pullCodeFolder({
    required String functionName,
    required File downloadedFile,
    required Directory functionsDirectory,
  }) async {
    _logger.info('Creating folder for pulling code...');
    final newDirectoryPath = '${functionsDirectory.path}/$functionName-pull';

    final newDirectory = Directory(newDirectoryPath);
    if (!newDirectory.existsSync()) {
      newDirectory.createSync(recursive: true);
      _logger.fine('Created Folder for new code pull');
    }

    _logger.info('Extracting the downloaded code from cloud');
    final result = await Process.run(
      'tar',
      [
        '-xzf',
        downloadedFile.path,
        '-C',
        newDirectoryPath,
      ],
    );

    if (result.exitCode != 0) {
      _logger.severe('Error extracting tarball: ${result.stderr}');
      throw AppwriteWorkbenchException(
          message: 'Error extracting tarball: ${result.stderr}',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: StackTrace.current);
    } else {
      _logger.finest('Extraction successful');
    }
  }

  Future<void> _pushVariables({
    required FunctionApi function,
    required ProjectApi project,
  }) async {
    _logger.info('Pushing variables');

    _logger.info('Getting variables from Cloud');
    final cloudVariables = await client.functions
        .listVariables(
          functionId: function.$id,
        )
        .then((value) => value.variables);

    _logger.info('Got variables from Cloud: $cloudVariables');

    _logger.info('Getting variables from Local');
    final localVariables = await listVariable(
      id: function.$id,
      project: project,
    );
    _logger.info('Got variables from Local: $localVariables');

    // Convert cloud and local variables to maps for easier lookup by key
    final cloudVariablesMap = {
      for (var variable in cloudVariables) variable.key: variable
    };
    final localVariablesMap = {
      for (var variable in localVariables) variable.key: variable
    };

    // Find variables that need to be created or updated
    for (var localVariable in localVariables) {
      if (cloudVariablesMap.containsKey(localVariable.key)) {
        // If the variable exists in the cloud, check if the value is different
        final cloudVariable = cloudVariablesMap[localVariable.key]!;
        if (cloudVariable.value != localVariable.value) {
          // Update variable in the cloud
          _logger.info('Updating variable: ${localVariable.key}');
          await client.functions.updateVariable(
            functionId: function.$id,
            variableId: cloudVariable.$id,
            value: localVariable.value,
            key: localVariable.key,
          );
        }
      } else {
        // If the variable does not exist in the cloud, create it
        _logger.info('Creating variable: ${localVariable.key}');
        await client.functions.createVariable(
          functionId: function.$id,
          key: localVariable.key,
          value: localVariable.value,
        );
      }
    }

    // Handle removal of cloud variables that are not present locally
    for (var cloudVariable in cloudVariables) {
      if (!localVariablesMap.containsKey(cloudVariable.key)) {
        _logger.info(
            'Variable exists in Cloud but not in Local: ${cloudVariable.key}');

        await client.functions.deleteVariable(
          functionId: function.$id,
          variableId: cloudVariable.$id,
        );
      }
    }
  }

  Future<File> _zipFunctionFolder({
    required Directory functionsDirectoryDedicated,
  }) async {
    final tempDir = Directory.systemTemp.createTempSync();
    final tempFile = File(path.join(tempDir.path, 'function.tar.gz'));
    final result = await Process.run(
      'tar',
      [
        '-czf',
        tempFile.path,
        '-C',
        functionsDirectoryDedicated.path,
        '.',
      ],
    );

    if (result.exitCode != 0) {
      throw AppwriteWorkbenchException(
          message: 'Error zipping function folder',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: StackTrace.current);
    }

    return tempFile;
  }

  @override
  Future<FunctionApi> getFunction({
    required String id,
    required ProjectWorkbench project,
  }) async {
    try {
      _logger.info('Getting function');
      final function = await LocalStorageService.isar.functionApis
          .filter()
          .$idEqualTo(id)
          .projects((q) {
        return q.idEqualTo(project.id);
      }).findFirst();

      if (function == null) {
        throw AppwriteWorkbenchException(
            message: 'Function not found',
            code: AppwriteWorkbenchExceptionCode.notFound,
            stackTrace: StackTrace.current);
      }

      return function;
    } catch (e, stackTrace) {
      _logger.severe('Error getting function: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error getting function',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  @override
  Future<appwrite_models.Variable> createVariable({
    required String id,
    required ProjectWorkbench project,
    required String key,
    required String value,
  }) async {
    try {
      _logger.info('Creating variable');
      final effectiveProject = project as ProjectApi;
      final function = await LocalStorageService.isar.functionApis
          .filter()
          .$idEqualTo(id)
          .projects((q) {
        return q.idEqualTo(project.id);
      }).findFirst();

      if (function == null) {
        throw AppwriteWorkbenchException(
            message: 'Function not found',
            code: AppwriteWorkbenchExceptionCode.notFound,
            stackTrace: StackTrace.current);
      }

      final response = LocalStorageService.instance.createVar(
        projectId: effectiveProject.projectId,
        functionId: function.$id,
        key: key,
        value: value,
      );

      _logger.info('Variable created: $response');

      return response;
    } catch (e, stackTrace) {
      _logger.severe('Error creating variable: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error creating variable',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  @override
  Future<List<appwrite_models.Variable>> listVariable({
    required String id,
    required ProjectWorkbench project,
  }) async {
    try {
      _logger.info('Getting variables');
      final effectiveProject = project as ProjectApi;
      final function = await LocalStorageService.isar.functionApis
          .filter()
          .$idEqualTo(id)
          .projects((q) {
        return q.idEqualTo(project.id);
      }).findFirst();

      if (function == null) {
        throw AppwriteWorkbenchException(
            message: 'Function not found',
            code: AppwriteWorkbenchExceptionCode.notFound,
            stackTrace: StackTrace.current);
      }

      final response = LocalStorageService.instance.getVars(
        projectId: effectiveProject.projectId,
        functionId: function.$id,
      );

      _logger.info('Got variables: $response');

      return response;
    } catch (e, stackTrace) {
      _logger.severe('Error getting variables: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error getting variables',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  @override
  Future<appwrite_models.Variable> updateVariable({
    required String id,
    required ProjectWorkbench project,
    required String key,
    required String value,
  }) async {
    try {
      _logger.info('Updating variable');
      final effectiveProject = project as ProjectApi;
      final function = await LocalStorageService.isar.functionApis
          .filter()
          .$idEqualTo(id)
          .projects((q) {
        return q.idEqualTo(project.id);
      }).findFirst();

      if (function == null) {
        throw AppwriteWorkbenchException(
            message: 'Function not found',
            code: AppwriteWorkbenchExceptionCode.notFound,
            stackTrace: StackTrace.current);
      }

      final response = LocalStorageService.instance.updateVar(
        projectId: effectiveProject.projectId,
        functionId: function.$id,
        key: key,
        value: value,
      );

      _logger.info('Variable updated: $response');

      return response;
    } catch (e, stackTrace) {
      _logger.severe('Error updating variable: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error updating variable',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  @override
  Future<void> deleteVariable({
    required String id,
    required ProjectWorkbench project,
    required String key,
  }) async {
    try {
      _logger.info('Deleting variable');
      final effectiveProject = project as ProjectApi;
      final function = await LocalStorageService.isar.functionApis
          .filter()
          .$idEqualTo(id)
          .projects((q) {
        return q.idEqualTo(project.id);
      }).findFirst();

      if (function == null) {
        throw AppwriteWorkbenchException(
            message: 'Function not found',
            code: AppwriteWorkbenchExceptionCode.notFound,
            stackTrace: StackTrace.current);
      }

      LocalStorageService.instance.deleteVar(
        projectId: effectiveProject.projectId,
        functionId: function.$id,
        key: key,
      );

      _logger.info('Variable deleted');
    } catch (e, stackTrace) {
      _logger.severe('Error deleting variable: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error deleting variable',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  @override
  Future<void> openVscode({
    required FunctionApi function,
  }) async {
    try {
      final base = LocalStorageService.base;
      final directory = path.join(
        base,
        'functions',
        function.$id,
      );
      _logger.finest('Directory: $directory');

      final shell = Shell();

      // Check if VSCode is installed
      bool isCodeInstalled = await _isCodeCommandAvailable();

      if (!isCodeInstalled) {
        _logger.warning(
            'VSCode is not installed or `code` command is not recognized.');

        // Attempt to install VSCode based on the platform
        if (Platform.isWindows) {
          _logger.info(
              'Please install Visual Studio Code from https://code.visualstudio.com/Download');
        } else if (Platform.isMacOS) {
          await shell.run('brew install --cask visual-studio-code');
          _logger.info('VSCode installed via Homebrew. Trying again...');
        } else if (Platform.isLinux) {
          await shell.run('sudo apt-get install code');
          _logger.info('VSCode installed via APT. Trying again...');
        } else {
          throw AppwriteWorkbenchException(
              message: 'Unsupported platform',
              code: AppwriteWorkbenchExceptionCode.unknown);
        }

        // Re-check if `code` command is available after installation attempt
        isCodeInstalled = await _isCodeCommandAvailable();

        if (!isCodeInstalled) {
          throw AppwriteWorkbenchException(
              message:
                  'VSCode installation failed or `code` command still not recognized.',
              code: AppwriteWorkbenchExceptionCode.unknown);
        }
      }

      // Open the directory in VSCode
      await shell.run('code "$directory"');
    } catch (e, stackTrace) {
      _logger.severe('Error opening VSCode: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error opening VSCode',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  Future<bool> _isCodeCommandAvailable() async {
    try {
      final shell = Shell();
      final result = await shell.run('code --version');

      // Check the exit code to determine if the command was successful
      if (result.isNotEmpty && result.first.exitCode == 0) {
        return true;
      } else {
        // Log the error message if the command failed
        _logger.severe('Failed to run code command: ${result.first.stderr}');
        return false;
      }
    } catch (e) {
      // Log the exception if the command throws an error
      _logger.severe('Error running code command: $e');
      return false;
    }
  }

  @override
  Future<void> openDirectory({
    required FunctionApi function,
  }) async {
    try {
      final base = LocalStorageService.base;
      final directory = path.join(
        base,
        'functions',
        function.$id,
      );
      _logger.finest('Directory: $directory');

      final shell = Shell();
      if (Platform.isWindows) {
        await shell.run('start "$directory"');
      } else if (Platform.isMacOS) {
        await shell.run('open "$directory"');
      } else if (Platform.isLinux) {
        await shell.run('xdg-open "$directory"');
      } else {
        throw AppwriteWorkbenchException(
            message: 'Unsupported platform',
            code: AppwriteWorkbenchExceptionCode.unknown);
      }
    } catch (e, stackTrace) {
      _logger.severe('Error opening directory: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error opening directory',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  @override
  Stream<FunctionApi> watchFunction({
    required String id,
    required ProjectWorkbench project,
  }) {
    try {
      _logger.info('Watching function');
      final functionQuery = LocalStorageService.isar.functionApis
          .filter()
          .$idEqualTo(id)
          .projects((q) {
        return q.idEqualTo(project.id);
      }).build();

      return functionQuery.watch(fireImmediately: true).map((event) {
        return event.first;
      });
    } catch (e, stackTrace) {
      _logger.severe('Error watching function: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error watching function',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  @override
  Future<FunctionApi> updateFunction({
    required FunctionApi function,
  }) async {
    try {
      LocalStorageService.isar.writeTxn(() async {
        function.updatedAt = DateTime.now().toUtc();
        await LocalStorageService.isar.functionApis.put(function);
      });

      return function;
    } catch (e, stackTrace) {
      _logger.severe('Error updating function: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error updating function',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }
}
