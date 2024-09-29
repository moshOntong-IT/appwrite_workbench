import 'dart:async';

import 'package:appwrite_workbench/features/functions/functions_provider.dart';
import 'package:appwrite_workbench/global_providars.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/function_services/function_service.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class FunctionVarsController extends AutoDisposeAsyncNotifier<String> {
  static final provider =
      AutoDisposeAsyncNotifierProvider<FunctionVarsController, String>(
          () => throw UnimplementedError());

  @override
  FutureOr<String> build() async {
    ref.onDispose(() {
      _subscription?.cancel();
    });

    final functionSelected = ref.read(functionSelectedProvider);
    final projectSelected = ref.read(projectSelectedProvider);
    final appwriteClient = ref.read(appwriteClientProvider);

    final effectiveFunctionService = projectSelected is ProjectApi
        ? FunctionService<FunctionApi>(client: appwriteClient)
        : FunctionService<FunctionJson>(client: appwriteClient);

    final variables = await effectiveFunctionService.listVariable(
      id: functionSelected.$id,
      project: projectSelected,
    );

    _subscription = effectiveFunctionService
        .watchVariable(
      id: functionSelected.$id,
      project: projectSelected,
    )
        .listen((event) {
      final converted = _variablesToString(event);
      state = AsyncValue.data(converted);
    });

    return _variablesToString(variables);
  }

  // Converts List<Variable> to String in .env format
  String _variablesToString(List<Variable> variables) {
    return variables
        .map((variable) => '${variable.key}=${variable.value}')
        .join('\n');
  }

  Future<void> saveVariables({
    required String envString,
    required void Function() onSuccess,
  }) async {
    try {
      state = const AsyncValue.loading();
      final functionSelected = ref.read(functionSelectedProvider);
      final projectSelected = ref.read(projectSelectedProvider);
      final appwriteClient = ref.read(appwriteClientProvider);

      final effectiveFunctionService = projectSelected is ProjectApi
          ? FunctionService<FunctionApi>(client: appwriteClient)
          : FunctionService<FunctionJson>(client: appwriteClient);

      final currentVariables = await effectiveFunctionService.listVariable(
        id: functionSelected.$id,
        project: projectSelected,
      );

      final newVariables = _stringToVariables(
        functionId: functionSelected.$id,
        envString: envString,
        currentVariables: currentVariables,
      );

      final response = await effectiveFunctionService.setVariables(
        id: functionSelected.$id,
        project: projectSelected,
        variables: newVariables,
      );

      state = AsyncValue.data(_variablesToString(response));

      onSuccess.call();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  List<Variable> _stringToVariables({
    required String functionId,
    required String envString,
    required List<Variable> currentVariables,
  }) {
    // Create a map of the current variables for easy lookup
    final variablesMap = {
      for (var variable in currentVariables) variable.key: variable,
    };

    // Split the envString into lines and build a map of new variables
    final newVariablesMap = <String, Variable>{};

    envString.split('\n').where((line) => line.isNotEmpty).forEach((line) {
      final keyValue = line.split('=');

      if (keyValue.length != 2) {
        throw FormatException("Invalid environment variable format: $line");
      }

      final key = keyValue[0].trim();
      final value = keyValue[1].trim();

      if (key.isEmpty) {
        throw const FormatException(
            "Environment variable key cannot be empty.");
      }

      // If the key exists, update it; otherwise, add the new variable
      newVariablesMap[key] = variablesMap.containsKey(key)
          ? Variable(
              $id: variablesMap[key]!.$id,
              $createdAt: variablesMap[key]!.$createdAt,
              $updatedAt: DateTime.now().toIso8601String(),
              key: key,
              value: value,
              resourceType: variablesMap[key]!.resourceType,
              resourceId: variablesMap[key]!.resourceId,
            )
          : Variable(
              $id: ID.unique(),
              $createdAt: DateTime.now().toIso8601String(),
              $updatedAt: DateTime.now().toIso8601String(),
              key: key,
              value: value,
              resourceType: 'function',
              resourceId: functionId,
            );
    });

    // Return only the new variables, effectively removing any old variables not in the string
    return newVariablesMap.values.toList();
  }

  StreamSubscription<List<Variable>>? _subscription;
}
