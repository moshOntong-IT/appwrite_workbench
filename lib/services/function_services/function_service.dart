import 'package:appwrite_workbench/models/project.dart';
import 'package:dart_appwrite/dart_appwrite.dart';

sealed class FunctionServiceBase<T extends Function> {

}

abstract class FunctionService<T extends ProjectWorkbench>
    extends FunctionServiceBase<T> {}
