import 'package:appwrite_workbench/core/appwrite_client.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/function_services/function_api_service.dart';
import 'package:appwrite_workbench/services/function_services/function_json_service.dart';
import 'package:dart_appwrite/models.dart';

sealed class FunctionServiceBase<T extends FunctionWorkbench> {
  Future<List<Runtime>> listRuntime({List<String>? queries});
  Future<T> createFunction({
    required String id,
    required String name,
    required String runtime,
    required ProjectWorkbench project,
  });
  Future<List<T>> listFunction({required ProjectWorkbench project});
  Stream<List<T>> watchFunction({required ProjectWorkbench project});
}

abstract class FunctionService<T extends FunctionWorkbench>
    extends FunctionServiceBase<T> {
  FunctionService();
  // factory FunctionService({required AppwriteClient client}) {
  //   if (T == FunctionApi) {
  //     return FunctionApiService(client: client) as FunctionService<T>;
  //   } else if (T == FunctionJson) {
  //     return FunctionJsonService(client: client) as FunctionService<T>;
  //   } else {
  //     throw UnimplementedError();
  //   }
  // }

  factory FunctionService.api({required AppwriteClient client}) =>
      FunctionApiService(client: client) as FunctionService<T>;

  factory FunctionService.json({required AppwriteClient client}) =>
      FunctionJsonService() as FunctionService<T>;
}
