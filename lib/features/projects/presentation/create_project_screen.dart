import 'package:appwrite_workbench/features/projects/presentation/controllers/create_project_controller.dart';
import 'package:appwrite_workbench/widgets/create_project_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:toastification/toastification.dart';

@RoutePage()
class CreateProjectScreen extends ConsumerWidget {
  const CreateProjectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShadButton(
              icon: const Icon(
                Icons.chevron_left,
                size: 16,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Gap(16),
            CreateProjectWidget(
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
                        toastification.show(
                            title: const Text('Project created'),
                            description: const Text(
                                'Project has been created successfully'),
                            type: ToastificationType.success);

                        Navigator.pop(context);
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
                        toastification.show(
                            title: const Text('Project created'),
                            description: const Text(
                                'Project has been created successfully'),
                            type: ToastificationType.success);
                        Navigator.pop(context);
                      },
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
