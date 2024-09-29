import 'dart:async';

import 'package:appwrite_workbench/features/functions/functions_provider.dart';
import 'package:appwrite_workbench/global_providars.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/function_services/function_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FunctionDetailController
    extends AutoDisposeAsyncNotifier<FunctionWorkbench> {
  static final provider = AutoDisposeAsyncNotifierProvider<
      FunctionDetailController, FunctionWorkbench>(
    () => throw UnimplementedError(),
  );

  @override
  FutureOr<FunctionWorkbench> build() {
    ref.onDispose(() {
      _subscription?.cancel();
    });

    final function = ref.read(functionSelectedProvider);
    final project = ref.read(projectSelectedProvider);

    final effectiveFunctionService = project is ProjectApi
        ? FunctionService<FunctionApi>(
            client: ref.read(appwriteClientProvider),
          )
        : FunctionService<FunctionJson>();

    _subscription = effectiveFunctionService
        .watchFunction(
      id: function.$id,
      project: project,
    )
        .listen((event) {
      state = AsyncData(event);
    });

    return function;
  }

  Future<void> updateFunction({
    FunctionWorkbench? function,
    required Function() onSuccess,
  }) async {
    try {
      state = const AsyncLoading();

      final project = ref.read(projectSelectedProvider);
      final client = ref.read(appwriteClientProvider);

      final effectiveFunctionService = project is ProjectApi
          ? FunctionService<FunctionApi>(
              client: client,
            )
          : FunctionService<FunctionJson>();

      await effectiveFunctionService.updateFunction(
        function: function!,
      );

      state = AsyncData(function);

      onSuccess();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  StreamSubscription<FunctionWorkbench>? _subscription;
}
