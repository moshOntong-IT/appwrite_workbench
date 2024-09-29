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
    required String runtime,
    required ProjectWorkbench project,
    String? name,
  });

  Future<T> updateFunction({
    required T function,
  });
  Future<void> pushFunction({
    required String id,
    required ProjectWorkbench project,
  });

  Future<void> pullFunction({
    required String id,
    required ProjectWorkbench project,
    bool replace = false,
  });

  Future<List<T>> listFunction({required ProjectWorkbench project});
  Future<List<Variable>> listVariable({
    required String id,
    required ProjectWorkbench project,
  });
  Future<Variable> createVariable({
    required String id,
    required ProjectWorkbench project,
    required String key,
    required String value,
  });
  Future<Variable> updateVariable({
    required String id,
    required ProjectWorkbench project,
    required String key,
    required String value,
  });

  Future<void> deleteVariable({
    required String id,
    required ProjectWorkbench project,
    required String key,
  });
  Future<void> openDirectory({
    required T function,
  });
  Future<void> openVscode({
    required T function,
  });
  Future<T> getFunction({
    required String id,
    required ProjectWorkbench project,
  });
  Stream<T> watchFunction({
    required String id,
    required ProjectWorkbench project,
  });
  Stream<List<T>> watchFunctions({required ProjectWorkbench project});
}

abstract class FunctionService<T extends FunctionWorkbench>
    extends FunctionServiceBase<T> {
  factory FunctionService({AppwriteClient? client}) {
    if (T == FunctionApi) {
      assert(client != null, 'client must not be null');
      if (client == null) {
        throw Exception('client must not be null');
      }
      return FunctionApiService(
        client: client,
      ) as FunctionService<T>;
    } else if (T == FunctionJson) {
      return FunctionJsonService() as FunctionService<T>;
    } else {
      throw Exception('Invalid type');
    }
  }
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

  factory FunctionService.json() => FunctionJsonService() as FunctionService<T>;
}
