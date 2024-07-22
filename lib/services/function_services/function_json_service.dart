import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/function_services/function_service.dart';
import 'package:dart_appwrite/models.dart';
import 'package:logging/logging.dart';

class FunctionJsonService implements FunctionService<FunctionJson> {
  FunctionJsonService();
  static final Logger _logger = Logger('FunctionJsonService');

  @override
  Future<List<Runtime>> listRuntime({List<String>? queries}) async {
    throw UnimplementedError();
  }

  @override
  Future<FunctionJson> createFunction({
    required String id,
    required String name,
    required String runtime,
    required ProjectWorkbench project,
  }) {
    // TODO: implement createFunction
    throw UnimplementedError();
  }

  @override
  Future<List<FunctionJson>> listFunction({required ProjectWorkbench project}) {
    // TODO: implement getFunctions
    throw UnimplementedError();
  }

  @override
  Stream<List<FunctionJson>> watchFunction(
      {required ProjectWorkbench project}) {
    // TODO: implement watchFunction
    throw UnimplementedError();
  }
}
