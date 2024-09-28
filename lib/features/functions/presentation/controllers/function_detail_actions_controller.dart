import 'dart:async';

import 'package:appwrite_workbench/global_providars.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/function_services/function_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FunctionDetailActionsController extends AutoDisposeAsyncNotifier<void> {
  static final provider =
      AutoDisposeAsyncNotifierProvider<FunctionDetailActionsController, void>(
          () => throw UnimplementedError());
  @override
  FutureOr<void> build() {}

  Future<void> openDirectory(
    FunctionWorkbench function,
    ProjectWorkbench project, {
    void Function(Object error)? onError,
  }) async {
    try {
      state = const AsyncLoading();
      final client = ref.read(appwriteClientProvider);
      if (function is FunctionApi) {
        FunctionService<FunctionApi>(
          client: client,
        ).openDirectory(function: function, project: project);
      } else if (function is FunctionJson) {
        FunctionService<FunctionJson>()
            .openDirectory(function: function, project: project);
      }

      state = const AsyncData(null);
    } catch (e, stackTrace) {
      onError?.call(e);
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> openVscode(
    FunctionWorkbench function,
    ProjectWorkbench project, {
    void Function(Object error)? onError,
  }) async {
    try {
      state = const AsyncLoading();
      final client = ref.read(appwriteClientProvider);
      if (function is FunctionApi) {
        FunctionService<FunctionApi>(
          client: client,
        ).openVscode(function: function, project: project);
      } else if (function is FunctionJson) {
        FunctionService<FunctionJson>()
            .openVscode(function: function, project: project);
      }

      state = const AsyncData(null);
    } catch (e, stackTrace) {
      onError?.call(e);
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
