import 'package:appwrite_workbench/features/auth/presentation/auth_screen.dart';
import 'package:appwrite_workbench/features/auth/presentation/auth_setup_screen.dart';
import 'package:appwrite_workbench/features/functions/presentation/functions_screen.dart';
import 'package:appwrite_workbench/features/project/presentation/project_screen.dart';
import 'package:appwrite_workbench/features/projects/presentation/create_project_screen.dart';
import 'package:appwrite_workbench/features/projects/presentation/no_projects_screen.dart';
import 'package:appwrite_workbench/features/projects/presentation/projects_screen.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/routers/project_route.dart';
import 'package:appwrite_workbench/routers/service_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'app_router.gr.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter(
    service: ref.read(serviceRouterProvider),
    ref: ref,
  );
});

@AutoRouterConfig()
class AppRouter extends _$AppRouter implements AutoRouteGuard {
  AppRouter({required this.service, required Ref ref}) : _ref = ref;

  // ignore: unused_field
  final Ref _ref;
  final ServiceRouter service;

  @override
  List<AutoRoute> get routes => [
        _ref.read(projectRouteProvider(service: service)),
        AutoRoute(
          page: ProjectsRoute.page,
          initial: true,
          path: '/projects',
        ),
        AutoRoute(page: CreateProjectRoute.page, path: '/create-projects'),
        AutoRoute(page: AuthRoute.page, path: '/login'),
        AutoRoute(page: SetupRoute.page, path: '/setup'),
        AutoRoute(page: NoProjectsRoute.page, path: '/no-projects'),
      ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isFirstTime = service.isFirstTime;
    final isSetUp = service.isSetup;
    final isLogin = service.login;
    final isGoingToLogin = resolver.route.name == AuthRoute.name;
    final isGoingToSetup = resolver.route.name == SetupRoute.name;
    final isGoingToNoProjects = resolver.route.name == NoProjectsRoute.name;
    final isGoingToProjects = resolver.route.name == ProjectsRoute.name;
    final isGoingToProject = resolver.route.name == ProjectRoute.name;
    if (!isSetUp && !isGoingToSetup) {
      resolver.next(false);
      resolver.redirect(
        SetupRoute(onDone: (value) {}),
      );
    } else if (isSetUp && !isLogin && !isGoingToLogin) {
      resolver.next(false);
      resolver.redirect(
        AuthRoute(onDone: (value) {}),
      );
    } else if (isSetUp && isFirstTime && isLogin && !isGoingToNoProjects) {
      resolver.next(false);
      resolver.redirect(
        NoProjectsRoute(onDone: (value) {}),
      );
    } else if (isSetUp &&
        !isFirstTime &&
        isLogin &&
        !isGoingToProjects &&
        !isGoingToProject) {
      resolver.next(false);
      resolver.redirect(
        const ProjectsRoute(),
      );
    } else {
      resolver.next(true);
    }
  }
}
