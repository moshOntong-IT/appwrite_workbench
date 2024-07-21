import 'package:appwrite_workbench/features/project/presentation/widgets/headbar_widget.dart';
import 'package:appwrite_workbench/features/project/presentation/widgets/project_drawer_widget.dart';
import 'package:appwrite_workbench/global_providars.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/routers/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ProjectScreen extends ConsumerWidget {
  const ProjectScreen({required this.project, super.key});

  final ProjectWorkbench project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        projectSelectedProvider.overrideWithValue(project),
      ],
      child: const _Main(),
    );
  }
}

class _Main extends ConsumerWidget {
  const _Main();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const HeadbarWidget(),
          Expanded(
            child: AutoTabsRouter(
              routes: const [
                FunctionsRoute(),
              ],
              builder: (context, child) {
                final tabsRouter = AutoTabsRouter.of(context);
                return Row(
                  children: [
                    ProjectDrawer(
                      currentIndex: tabsRouter.activeIndex,
                      onIndexChange: (index) {
                        tabsRouter.setActiveIndex(index);
                      },
                    ),
                    Expanded(child: child),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
