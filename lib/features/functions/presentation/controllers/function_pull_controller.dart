import 'dart:async';

import 'package:appwrite_workbench/global_providars.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/function_services/function_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FunctionPullController extends AutoDisposeAsyncNotifier<void> {
  static final provider =
      AutoDisposeAsyncNotifierProvider<FunctionPullController, void>(
          () => throw UnimplementedError());

  @override
  FutureOr<void> build() {}
  Future<void> pullFunction({
    required FunctionWorkbench function,
    required ProjectWorkbench project,
    bool replace = false,
    void Function()? onSuccess,
    void Function(Object error)? onError,
  }) async {
    try {
      state = const AsyncLoading();

      final client = ref.read(appwriteClientProvider);
      if (function is FunctionApi) {
        await FunctionService<FunctionApi>(
          client: client,
        ).pullFunction(
          id: function.$id,
          project: project,
          replace: replace,
        );
      } else if (function is FunctionJson) {
        await FunctionService<FunctionJson>().pullFunction(
          id: function.$id,
          project: project,
        );
      }
      onSuccess?.call();
    } catch (e, stackTrace) {
      onError?.call(e);
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
