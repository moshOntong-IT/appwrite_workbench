import 'package:appwrite_workbench/routers/app_router.dart';
import 'package:appwrite_workbench/routers/service_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_route.g.dart';

@Riverpod(keepAlive: true)
AutoRoute projectRoute(ProjectRouteRef ref, {required ServiceRouter service}) =>
    AutoRoute(
      page: ProjectRoute.page,
      path: '/project',
      children: [
        AutoRoute(page: FunctionsRoute.page, path: 'functions'),
      ],
      maintainState: false,
    );
