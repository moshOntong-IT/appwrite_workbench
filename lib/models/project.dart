import 'package:appwrite_workbench/models/service.dart';
import 'package:isar/isar.dart';

part 'project.g.dart';

enum ProjectType { api, json }

sealed class ProjectWorkbench extends ServiceWorkbench {
  ProjectWorkbench({required this.type});
  late String name;

  @enumerated
  ProjectType type;
}

@collection
class ProjectApi extends ProjectWorkbench {
  ProjectApi() : super(type: ProjectType.api);
  late String projectId;
  late String endpoint;

  @ignore
  late String apiKey;
}

@collection
class ProjectJson extends ProjectWorkbench {
  ProjectJson() : super(type: ProjectType.json);
  late String path;
}
// extension ProjectMapX on Map<String, dynamic> {
//   Project toProject() => Project.fromJson(this);
// }
