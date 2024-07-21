import 'dart:async';

import 'package:appwrite_workbench/core/appwrite_workbench_code.dart';
import 'package:appwrite_workbench/models/appwrite_workbench_exception.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/project_services/project_service.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final createProjectControllerProvider =
    AutoDisposeAsyncNotifierProvider<CreateProjectController, void>(
        CreateProjectController.new);

class CreateProjectController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() async {}

  Future<void> addProject({
    required ProjectWorkbench project,
    required VoidCallback onDuplicate,
    required VoidCallback onProjectCreated,
    String? apiKey,
  }) async {
    try {
      if (project is ProjectApi) {
        await ProjectService<ProjectApi>().createProject(
          project,
        );
      } else if (project is ProjectJson) {
        await ProjectService<ProjectJson>().createProject(
          project,
        );
      }

      onProjectCreated();
    } on AppwriteWorkbenchException catch (e) {
      if (e.code == AppwriteWorkbenchExceptionCode.duplicate) {
        onDuplicate();
      } else {
        rethrow;
      }
    }
  }
}
