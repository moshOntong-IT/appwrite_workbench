// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      final args = routeData.argsAs<AuthRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AuthScreen(
          onDone: args.onDone,
          key: args.key,
        ),
      );
    },
    CreateProjectRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateProjectScreen(),
      );
    },
    FunctionsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FunctionsScreen(),
      );
    },
    NoProjectsRoute.name: (routeData) {
      final args = routeData.argsAs<NoProjectsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NoProjectsScreen(
          onDone: args.onDone,
          key: args.key,
        ),
      );
    },
    ProjectRoute.name: (routeData) {
      final args = routeData.argsAs<ProjectRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProjectScreen(
          project: args.project,
          key: args.key,
        ),
      );
    },
    ProjectsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProjectsScreen(),
      );
    },
    SetupRoute.name: (routeData) {
      final args = routeData.argsAs<SetupRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SetupScreen(
          onDone: args.onDone,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    required dynamic Function(bool) onDone,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AuthRoute.name,
          args: AuthRouteArgs(
            onDone: onDone,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<AuthRouteArgs> page = PageInfo<AuthRouteArgs>(name);
}

class AuthRouteArgs {
  const AuthRouteArgs({
    required this.onDone,
    this.key,
  });

  final dynamic Function(bool) onDone;

  final Key? key;

  @override
  String toString() {
    return 'AuthRouteArgs{onDone: $onDone, key: $key}';
  }
}

/// generated route for
/// [CreateProjectScreen]
class CreateProjectRoute extends PageRouteInfo<void> {
  const CreateProjectRoute({List<PageRouteInfo>? children})
      : super(
          CreateProjectRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateProjectRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FunctionsScreen]
class FunctionsRoute extends PageRouteInfo<void> {
  const FunctionsRoute({List<PageRouteInfo>? children})
      : super(
          FunctionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FunctionsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NoProjectsScreen]
class NoProjectsRoute extends PageRouteInfo<NoProjectsRouteArgs> {
  NoProjectsRoute({
    required dynamic Function(bool) onDone,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          NoProjectsRoute.name,
          args: NoProjectsRouteArgs(
            onDone: onDone,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'NoProjectsRoute';

  static const PageInfo<NoProjectsRouteArgs> page =
      PageInfo<NoProjectsRouteArgs>(name);
}

class NoProjectsRouteArgs {
  const NoProjectsRouteArgs({
    required this.onDone,
    this.key,
  });

  final dynamic Function(bool) onDone;

  final Key? key;

  @override
  String toString() {
    return 'NoProjectsRouteArgs{onDone: $onDone, key: $key}';
  }
}

/// generated route for
/// [ProjectScreen]
class ProjectRoute extends PageRouteInfo<ProjectRouteArgs> {
  ProjectRoute({
    required ProjectWorkbench project,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ProjectRoute.name,
          args: ProjectRouteArgs(
            project: project,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProjectRoute';

  static const PageInfo<ProjectRouteArgs> page =
      PageInfo<ProjectRouteArgs>(name);
}

class ProjectRouteArgs {
  const ProjectRouteArgs({
    required this.project,
    this.key,
  });

  final ProjectWorkbench project;

  final Key? key;

  @override
  String toString() {
    return 'ProjectRouteArgs{project: $project, key: $key}';
  }
}

/// generated route for
/// [ProjectsScreen]
class ProjectsRoute extends PageRouteInfo<void> {
  const ProjectsRoute({List<PageRouteInfo>? children})
      : super(
          ProjectsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProjectsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SetupScreen]
class SetupRoute extends PageRouteInfo<SetupRouteArgs> {
  SetupRoute({
    required dynamic Function(bool) onDone,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SetupRoute.name,
          args: SetupRouteArgs(
            onDone: onDone,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SetupRoute';

  static const PageInfo<SetupRouteArgs> page = PageInfo<SetupRouteArgs>(name);
}

class SetupRouteArgs {
  const SetupRouteArgs({
    required this.onDone,
    this.key,
  });

  final dynamic Function(bool) onDone;

  final Key? key;

  @override
  String toString() {
    return 'SetupRouteArgs{onDone: $onDone, key: $key}';
  }
}
