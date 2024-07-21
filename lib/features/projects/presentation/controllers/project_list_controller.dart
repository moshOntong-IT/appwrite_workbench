import 'dart:async';

import 'package:appwrite_workbench/features/projects/presentation/projects_providers.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/project_services/project_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final projectListController = AutoDisposeAsyncNotifierProvider<
    ProjectListController, List<ProjectWorkbench>>(ProjectListController.new);

class ProjectListController
    extends AutoDisposeAsyncNotifier<List<ProjectWorkbench>> {
  @override
  FutureOr<List<ProjectWorkbench>> build() async {
    ref.onDispose(() {
      _subscription?.cancel();
    });

    return _getProjects();
  }

  Future<List<ProjectWorkbench>> _getProjects() async {
    final projectTypeSelected = ref.read(projectTypeSelectedProvider);
    if (projectTypeSelected == ProjectType.api) {
      final response = await ProjectService<ProjectApi>().getProjects();
      _subscription?.cancel();

      _subscription =
          ProjectService<ProjectApi>().watchProject().listen((event) {
        state = AsyncValue.data(event);
      });

      return response;
    } else {
      final response = await ProjectService<ProjectJson>().getProjects();

      _subscription?.cancel();

      _subscription =
          ProjectService<ProjectJson>().watchProject().listen((event) {
        state = AsyncValue.data(event);
      });
      return response;
    }
  }

  StreamSubscription<List<ProjectWorkbench>>? _subscription;
}
