import 'package:appwrite_workbench/core/appwrite_client.dart';
import 'package:appwrite_workbench/core/appwrite_workbench_code.dart';
import 'package:appwrite_workbench/models/appwrite_workbench_exception.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/services/function_services/function_service.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:logging/logging.dart';

class FunctionJsonService implements FunctionService<FunctionJson> {
  FunctionJsonService({required this.client});
  static final Logger _logger = Logger('FunctionJsonService');

  final AppwriteClient client;

  @override
  Future<List<Runtime>> listRuntime({List<String>? queries}) async {
    try {
      final response = await client.functions.listRuntimes();

      return response.runtimes;
    } on AppwriteException catch (e, stackTrace) {
      _logger.severe('Error getting runtimes: $e', e, stackTrace);

      throw AppwriteWorkbenchException(
          message: 'Error getting runtimes',
          code: AppwriteWorkbenchExceptionCode.unknown,
          stackTrace: stackTrace);
    }
  }
}
