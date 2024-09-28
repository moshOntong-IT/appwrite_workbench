import 'package:appwrite_workbench/features/projects/presentation/controllers/project_list_controller.dart';
import 'package:appwrite_workbench/features/projects/presentation/controllers/remove_project_controller.dart';
import 'package:appwrite_workbench/features/projects/presentation/create_project_screen.dart';
import 'package:appwrite_workbench/features/projects/presentation/projects_providers.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/routers/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:toastification/toastification.dart';

@RoutePage()
class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        projectTypeSelectedProvider.overrideWith((ref) => ProjectType.api),
        projectListController.overrideWith(ProjectListController.new),
      ],
      child: const _Main(),
    );
  }
}

class _Main extends ConsumerWidget {
  const _Main();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listProject = ref.watch(projectListController);

    return Scaffold(
      body: listProject.when(
        data: (value) {
          return Center(
            child: MaxWidthBox(
              maxWidth: 1000,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: ShadTheme.of(context).colorScheme.muted),
                    right: BorderSide(
                        color: ShadTheme.of(context).colorScheme.muted),
                  ),
                ),
                height: 800,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Appwrite Projects',
                                style:
                                    ShadTheme.of(context).textTheme.h2.copyWith(
                                          fontWeight: FontWeight.w900,
                                          color: const Color(0xFFF02D65),
                                        )),
                            Text(
                              'Connect a project to continue',
                              style: ShadTheme.of(context).textTheme.muted,
                            ),
                          ],
                        ),
                        const Spacer(),
                        ShadButton(
                          child: const Text('Link Project'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CreateProjectScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const Gap(16),
                    const _Tabbar(),
                    const Divider(),
                    const Gap(16),
                    const ShadAlert(
                      iconSrc: LucideIcons.info,
                      title: Text('Fact:'),
                      description: Text(
                        'We encrypt and store the important data securely. Don\'t worry about the security, as long as you keep your password save, you are good to go!',
                      ),
                    ),
                    const Gap(16),
                    const _List(),
                  ],
                ),
              ),
            ),
          );
        },
        error: (err, stackTrace) {
          return ErrorWidget(err);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _Tabbar extends ConsumerWidget {
  const _Tabbar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(projectTypeSelectedProvider, (prev, next) {
      if (prev != next) {
        ref.invalidate(projectListController);
      }
    });
    return ShadTabs<ProjectType>(
      value: ProjectType.api,
      tabs: [
        ShadTab(
          value: ProjectType.api,
          child: const Text('API Project'),
          onPressed: () {
            ref.read(projectTypeSelectedProvider.notifier).state =
                ProjectType.api;
          },
        ),
        ShadTab(
          value: ProjectType.json,
          child: const Text('JSON Project'),
          onPressed: () {
            ref.read(projectTypeSelectedProvider.notifier).state =
                ProjectType.json;
          },
        ),
      ],
    );
  }
}

class _List extends ConsumerWidget {
  const _List();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listProject = ref.watch(projectListController).value!;
    return SizedBox(
      height: 380,
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 16,
          children: [
            for (int i = 0; i < listProject.length; i++)
              listProject[i] is ProjectJson
                  ? _buildProjectJsonCard(
                      context,
                      index: i,
                      project: listProject[i] as ProjectJson,
                      ref: ref,
                    )
                  : _buildProjectApiCard(
                      context,
                      index: i,
                      project: listProject[i] as ProjectApi,
                      ref: ref,
                    ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectJsonCard(
    BuildContext context, {
    required int index,
    required ProjectJson project,
    required WidgetRef ref,
  }) {
    return ShadCard(
        width: 300,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  project.name,
                ),
              ),
            ),
            ShadButton.destructive(
              icon: const Icon(
                LucideIcons.trash2,
                size: 16,
              ),
              onPressed: () {
                ref
                    .read(removeProjectControllerProvider.notifier)
                    .removeProject(
                      project: project,
                    );
                toastification.show(
                  title: const Text('Project deleted'),
                  description: const Text('Project has been deleted'),
                  type: ToastificationType.success,
                );
              },
            ),
          ],
        ),
        description: Column(
          children: [
            const Gap(16),
            const Text('Appwrite JSON'),
            const Divider(),
            ShadTooltip(
              anchor: const ShadAnchorAuto(),
              builder: (context) => Text(
                project.path,
              ),
              child: Text(
                project.path,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Gap(16),
          ],
        ),
        footer: ShadButton(
          width: double.infinity,
          child: const Text(
            'Connect',
          ),
          onPressed: () {
            context.replaceRoute(ProjectRoute(project: project));
          },
        ));
  }

  Widget _buildProjectApiCard(
    BuildContext context, {
    required int index,
    required ProjectApi project,
    required WidgetRef ref,
  }) {
    return ShadCard(
        height: 250,
        width: 300,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              project.name,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ShadButton.destructive(
              icon: const Icon(
                LucideIcons.trash2,
                size: 16,
              ),
              onPressed: () {
                ref
                    .read(removeProjectControllerProvider.notifier)
                    .removeProject(
                      project: project,
                    );
                toastification.show(
                  title: const Text('Project deleted'),
                  description: const Text('Project has been deleted'),
                  type: ToastificationType.success,
                );
              },
            ),
          ],
        ),
        description: Column(
          children: [
            const Gap(16),
            Text(project.projectId),
            const Divider(),
            Text(project.endpoint),
            const Gap(16),
          ],
        ),
        footer: ShadButton(
          width: double.infinity,
          child: const Text('Connect'),
          onPressed: () {
            context.replaceRoute(ProjectRoute(project: project));
          },
        ));
  }
}
