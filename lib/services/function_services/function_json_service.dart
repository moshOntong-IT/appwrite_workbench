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
}
