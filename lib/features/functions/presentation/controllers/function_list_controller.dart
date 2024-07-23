import 'dart:async';

import 'package:appwrite_workbench/global_providars.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/function_services/function_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final functionListControllerProvider = AutoDisposeAsyncNotifierProvider<
    FunctionListController,
    List<FunctionWorkbench>>(() => throw UnimplementedError());

class FunctionListController
    extends AutoDisposeAsyncNotifier<List<FunctionWorkbench>> {
  @override
  FutureOr<List<FunctionWorkbench>> build() {
    ref.onDispose(() {
      _subscription?.cancel();
    });

    return _get();
  }

  Future<List<FunctionWorkbench>> _get() async {
    final project = ref.read(projectSelectedProvider);

    if (project.type == ProjectType.api) {
      final client = ref.read(appwriteClientProvider);
      _subscription?.cancel();

      _subscription = FunctionService.api(client: client)
          .watchFunction(project: project)
          .listen((event) {
        state = AsyncValue.data(event);
      });
      return FunctionService.api(client: client).listFunction(project: project);
    } else {
      return FunctionService.json().listFunction(project: project);
    }
  }

  StreamSubscription<List<FunctionWorkbench>>? _subscription;
}
