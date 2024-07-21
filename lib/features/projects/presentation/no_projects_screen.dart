import 'package:appwrite_workbench/features/projects/presentation/controllers/create_project_controller.dart';
import 'package:appwrite_workbench/routers/service_router.dart';
import 'package:appwrite_workbench/widgets/create_project_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

@RoutePage()
class NoProjectsScreen extends ConsumerWidget {
  const NoProjectsScreen({required this.onDone, super.key});

  final Function(bool) onDone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: CreateProjectWidget(
          onJsonCreate: (project) {
            ref.read(createProjectControllerProvider.notifier).addProject(
                  project: project,
                  onDuplicate: () {
                    toastification.show(
                        title: const Text('Project already exists'),
                        description: const Text(
                            'Project with the same project id already exists, please choose a different id'),
                        type: ToastificationType.error);
                  },
                  onProjectCreated: () {
                    ref.read(serviceRouterProvider).isFirstTime = false;
                    toastification.show(
                        title: const Text('Project created'),
                        description:
                            const Text('Project has been created successfully'),
                        type: ToastificationType.success);
                    onDone.call(true);
                  },
                );
          },
          onApiCreate: (project) {
            ref.read(createProjectControllerProvider.notifier).addProject(
                  project: project,
                  onDuplicate: () {
                    toastification.show(
                        title: const Text('Project already exists'),
                        description: const Text(
                            'Project with the same project id already exists, please choose a different id'),
                        type: ToastificationType.error);
                  },
                  onProjectCreated: () {
                    ref.read(serviceRouterProvider).isFirstTime = false;
                    toastification.show(
                        title: const Text('Project created'),
                        description:
                            const Text('Project has been created successfully'),
                        type: ToastificationType.success);
                    onDone.call(true);
                  },
                );
          },
        ),
      ),
    );
  }
}
