import 'dart:async';

import 'package:appwrite_workbench/global_providars.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/function_services/function_service.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final functionsControllerProvider =
    AutoDisposeAsyncNotifierProvider<FunctionsController, void>(
        () => FunctionsController());

class FunctionsController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> createFunction({
    required String id,
    required String name,
    required String runtime,
    required ProjectWorkbench project,
    VoidCallback? onSuccess,
  }) async {
    try {
      state = const AsyncLoading();

      if (project.type == ProjectType.api) {
        await createFunctionApi(
          id: id,
          name: name,
          runtime: runtime,
          project: project,
        );
        onSuccess?.call();
      } else if (project.type == ProjectType.json) {
        /// TODO it must redirect to the CLI
        throw Exception('Not supported yet');
      }
      state = const AsyncData(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> createFunctionApi({
    required String id,
    required String name,
    required String runtime,
    required ProjectWorkbench project,
  }) async {
    final client = ref.read(appwriteClientProvider);
    await FunctionService.api(client: client).createFunction(
      id: id,
      name: name,
      runtime: runtime,
      project: project,
    );
  }
}
