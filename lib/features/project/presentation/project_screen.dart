import 'package:appwrite_workbench/core/appwrite_client.dart';
import 'package:appwrite_workbench/core/provider_scope_extension.dart';
import 'package:appwrite_workbench/features/project/presentation/widgets/headbar_widget.dart';
import 'package:appwrite_workbench/features/project/presentation/widgets/project_drawer_widget.dart';
import 'package:appwrite_workbench/global_providars.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/routers/app_router.dart';
import 'package:appwrite_workbench/services/local_storage_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ProjectScreen extends ConsumerWidget implements AutoRouteWrapper {
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

  @override
  Widget wrappedRoute(BuildContext context) {
    return scope(overrides: [
      if (project is ProjectApi)
        appwriteClientProvider.overrideWith((ref) {
          final apiKey = LocalStorageService.instance
              .getKey(projectId: (project as ProjectApi).projectId);
          final appwriteClient = AppwriteClient(
            apiKey: apiKey,
            projectApi: project as ProjectApi,
          );

          return appwriteClient;
        }),
    ]);
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
