import 'dart:async';

import 'package:appwrite_workbench/global_providars.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/function_services/function_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FunctionPushController extends AutoDisposeAsyncNotifier<void> {
  static final provider =
      AutoDisposeAsyncNotifierProvider<FunctionPushController, void>(
          () => throw UnimplementedError());

  @override
  FutureOr<void> build() {}
  Future<void> pushFunction({
    required FunctionWorkbench function,
    required ProjectWorkbench project,
    void Function()? onSuccess,
    void Function(Object error)? onError,
  }) async {
    try {
      state = const AsyncLoading();

      final client = ref.read(appwriteClientProvider);
      if (function is FunctionApi) {
        FunctionService<FunctionApi>(
          client: client,
        ).pushFunction(
          id: function.$id,
          project: project,
        );
      } else if (function is FunctionJson) {
        FunctionService<FunctionJson>().pushFunction(
          id: function.$id,
          project: project,
        );
      }
      onSuccess?.call();
      state = const AsyncData(null);
    } catch (e, stackTrace) {
      onError?.call(e);
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
