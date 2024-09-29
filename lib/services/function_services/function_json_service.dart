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
    required String runtime,
    required ProjectWorkbench project,
    String? name,
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
  Stream<List<FunctionJson>> watchFunctions(
      {required ProjectWorkbench project}) {
    // TODO: implement watchFunction
    throw UnimplementedError();
  }

  @override
  Future<void> pushFunction({
    required String id,
    required ProjectWorkbench project,
  }) {
    // TODO: implement createDeployment
    throw UnimplementedError();
  }

  @override
  Future<FunctionJson> getFunction(
      {required String id, required ProjectWorkbench project}) {
    // TODO: implement getFunction
    throw UnimplementedError();
  }

  @override
  Future<Variable> createVariable({
    required String id,
    required ProjectWorkbench project,
    required String key,
    required String value,
  }) {
    // TODO: implement createVariable
    throw UnimplementedError();
  }

  @override
  Future<List<Variable>> listVariable({
    required String id,
    required ProjectWorkbench project,
  }) {
    // TODO: implement listVariable
    throw UnimplementedError();
  }

  @override
  Future<Variable> updateVariable({
    required String id,
    required ProjectWorkbench project,
    required String key,
    required String value,
  }) {
    // TODO: implement updateVariable
    throw UnimplementedError();
  }

  @override
  Future<void> deleteVariable(
      {required String id,
      required ProjectWorkbench project,
      required String key}) {
    // TODO: implement deleteVariable
    throw UnimplementedError();
  }

  @override
  Future<void> pullFunction({
    required String id,
    required ProjectWorkbench project,
    bool replace = false,
  }) {
    // TODO: implement pullFunction
    throw UnimplementedError();
  }

  @override
  Future<void> openVscode({
    required FunctionJson function,
  }) {
    // TODO: implement opeVscode
    throw UnimplementedError();
  }

  @override
  Future<void> openDirectory({
    required FunctionJson function,
  }) {
    // TODO: implement openDirectory
    throw UnimplementedError();
  }

  @override
  Stream<FunctionJson> watchFunction(
      {required String id, required ProjectWorkbench project}) {
    // TODO: implement watchFunction
    throw UnimplementedError();
  }

  @override
  Future<FunctionJson> updateFunction({
    required FunctionJson function,
  }) {
    // TODO: implement updateFunction
    throw UnimplementedError();
  }

  @override
  Stream<List<Variable>> watchVariable(
      {required String id, required ProjectWorkbench project}) {
    // TODO: implement watchVariable
    throw UnimplementedError();
  }

  @override
  Future<List<Variable>> setVariables(
      {required String id,
      required ProjectWorkbench project,
      required List<Variable> variables}) {
    // TODO: implement setVariables
    throw UnimplementedError();
  }
}
