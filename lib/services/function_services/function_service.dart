import 'package:appwrite_workbench/core/appwrite_client.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/services/function_services/function_api_service.dart';
import 'package:appwrite_workbench/services/function_services/function_json_service.dart';
import 'package:dart_appwrite/models.dart';

sealed class FunctionServiceBase<T extends FunctionWorkbench> {
  Future<List<Runtime>> listRuntime({List<String>? queries});
}

abstract class FunctionService<T extends FunctionWorkbench>
    extends FunctionServiceBase<T> {
  factory FunctionService({required AppwriteClient client}) {
    if (T is FunctionApi) {
      return FunctionApiService(client: client) as FunctionService<T>;
    } else if (T is FunctionJson) {
      return FunctionJsonService(client: client) as FunctionService<T>;
    } else {
      throw UnimplementedError();
    }
  }
}
