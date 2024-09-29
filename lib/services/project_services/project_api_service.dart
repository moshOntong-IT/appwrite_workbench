import 'dart:io';

import 'package:appwrite_workbench/core/appwrite_workbench_code.dart';
import 'package:appwrite_workbench/models/appwrite_workbench_exception.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/local_storage_service.dart';
import 'package:appwrite_workbench/services/project_services/project_service.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';

class ProjectApiService implements ProjectService<ProjectApi> {
  static final Logger _logger = Logger('ProjectApiService');

  @override
  Future<void> removeProject(ProjectApi project) async {
    await LocalStorageService.isar.writeTxn(() async {
      await LocalStorageService.isar.projectApis.delete(
        project.id,
      );
    });
  }

  @override
  Future<ProjectApi> createProject(ProjectApi project) async {
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

      return project;
    } catch (e, stackTrace) {
      _logger.severe('Error creating project: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error creating project',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }

  @override
  Future<List<ProjectApi>> getProjects() async {
    try {
      final projects =
          await LocalStorageService.isar.projectApis.where().findAll();
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
  Stream<List<ProjectApi>> watchProject() {
    return LocalStorageService.isar.projectApis.where().watch();
  }

  @override
  Future<void> openDirectory(ProjectApi project) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final directory = p.join(dir.path, 'appwrite_workbench');
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
  Future<void> openTerminal(ProjectApi project) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final directory = p.join(dir.path, 'appwrite_workbench');
      _logger.finest('Directory: $directory');

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

  // Future<Directory> _createProjectFolder({required String projectId}) async {
  //   _logger.info('Create project folder: $projectId');
  //   final base = LocalStorageService.base;

  //   final projectsDirectory = Directory(p.join(base, 'projects'));

  //   if (!projectsDirectory.existsSync()) {
  //     _logger.info('Creating projects directory');
  //     projectsDirectory.createSync();
  //     _logger.finest('Projects directory created');
  //   }

  //   final projectDirectory =
  //       Directory(p.join(projectsDirectory.path, projectId));

  //   if (!projectDirectory.existsSync()) {
  //     _logger.info('Creating project directory');
  //     projectDirectory.createSync();
  //     _logger.finest('Project directory created');
  //   }

  //   return projectDirectory;
  // }
}
