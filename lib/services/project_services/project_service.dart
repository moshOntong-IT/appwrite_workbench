import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/project_services/project_api_service.dart';
import 'package:appwrite_workbench/services/project_services/project_json_service.dart';

sealed class ProjectBaseService<T extends ProjectWorkbench> {
  Future<List<T>> getProjects();
  Stream<List<T>> watchProject();

  Future<T> createProject(T project);
  Future<void> removeProject(T project);
  Future<void> openTerminal(T project);
  Future<void> openDirectory(T project);
}

abstract class ProjectService<T extends ProjectWorkbench>
    extends ProjectBaseService<T> {
  factory ProjectService() {
    if (T == ProjectApi) {
      return ProjectApiService() as ProjectService<T>;
    } else if (T == ProjectJson) {
      return ProjectJsonService() as ProjectService<T>;
    } else {
      throw Exception('Invalid type');
    }
  }
}
