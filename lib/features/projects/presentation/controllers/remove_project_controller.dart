import 'dart:async';

import 'package:appwrite_workbench/models/appwrite_workbench_exception.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/project_services/project_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final removeProjectControllerProvider =
    AutoDisposeAsyncNotifierProvider<RemoveProjectController, void>(
        RemoveProjectController.new);

class RemoveProjectController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() async {}

  Future<void> removeProject({
    required ProjectWorkbench project,
  }) async {
    state = const AsyncValue.loading();
    try {
      if (project is ProjectApi) {
        await ProjectService<ProjectApi>().removeProject(
          project,
        );
      } else if (project is ProjectJson) {
        await ProjectService<ProjectJson>().removeProject(
          project,
        );
      }
    } on AppwriteWorkbenchException catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
