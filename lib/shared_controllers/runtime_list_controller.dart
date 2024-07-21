import 'dart:async';

import 'package:appwrite_workbench/global_providars.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/services/function_services/function_service.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final runtimeListControllerProvider =
    AutoDisposeAsyncNotifierProvider<RuntimeListController, List<Runtime>>(
        RuntimeListController.new);

class RuntimeListController extends AutoDisposeAsyncNotifier<List<Runtime>> {
  @override
  FutureOr<List<Runtime>> build() {
    final client = ref.read(appwriteClientProvider);
    final runtimes = FunctionService<FunctionApi>(client: client).listRuntime();
    return runtimes;
  }

  Future<void> searchRuntime(String query) async {
    try {
      final client = ref.read(appwriteClientProvider);
      final runtimes = await FunctionService<FunctionApi>(client: client)
          .listRuntime(queries: [
        Query.contains('name', query),
      ]);

      state = AsyncValue.data(runtimes);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
