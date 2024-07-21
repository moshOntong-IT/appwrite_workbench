import 'dart:async';

import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/project_services/project_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final headbarActionsControllerProvider =
    AutoDisposeAsyncNotifierProvider<HeadbarActionsController, void>(
        () => throw UnimplementedError());

class HeadbarActionsController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> openDirectory(ProjectWorkbench project) async {
    try {
      state = const AsyncLoading();
      if (project is ProjectApi) {
        ProjectService<ProjectApi>().openDirectory(project);
      } else if (project is ProjectJson) {
        ProjectService<ProjectJson>().openDirectory(project);
      }

      state = const AsyncData(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> openTerminal(ProjectWorkbench project) async {
    try {
      state = const AsyncLoading();
      if (project is ProjectApi) {
        ProjectService<ProjectApi>().openTerminal(project);
      } else if (project is ProjectJson) {
        ProjectService<ProjectJson>().openTerminal(project);
      }

      state = const AsyncData(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
