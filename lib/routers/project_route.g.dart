// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_route.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectRouteHash() => r'289430c8dcf9e4cb4bba506e2908659f903b39dc';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [projectRoute].
@ProviderFor(projectRoute)
const projectRouteProvider = ProjectRouteFamily();

/// See also [projectRoute].
class ProjectRouteFamily extends Family<AutoRoute> {
  /// See also [projectRoute].
  const ProjectRouteFamily();

  /// See also [projectRoute].
  ProjectRouteProvider call({
    required ServiceRouter service,
  }) {
    return ProjectRouteProvider(
      service: service,
    );
  }

  @override
  ProjectRouteProvider getProviderOverride(
    covariant ProjectRouteProvider provider,
  ) {
    return call(
      service: provider.service,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'projectRouteProvider';
}

/// See also [projectRoute].
class ProjectRouteProvider extends Provider<AutoRoute> {
  /// See also [projectRoute].
  ProjectRouteProvider({
    required ServiceRouter service,
  }) : this._internal(
          (ref) => projectRoute(
            ref as ProjectRouteRef,
            service: service,
          ),
          from: projectRouteProvider,
          name: r'projectRouteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$projectRouteHash,
          dependencies: ProjectRouteFamily._dependencies,
          allTransitiveDependencies:
              ProjectRouteFamily._allTransitiveDependencies,
          service: service,
        );

  ProjectRouteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.service,
  }) : super.internal();

  final ServiceRouter service;

  @override
  Override overrideWith(
    AutoRoute Function(ProjectRouteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProjectRouteProvider._internal(
        (ref) => create(ref as ProjectRouteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        service: service,
      ),
    );
  }

  @override
  ProviderElement<AutoRoute> createElement() {
    return _ProjectRouteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectRouteProvider && other.service == service;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, service.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProjectRouteRef on ProviderRef<AutoRoute> {
  /// The parameter `service` of this provider.
  ServiceRouter get service;
}

class _ProjectRouteProviderElement extends ProviderElement<AutoRoute>
    with ProjectRouteRef {
  _ProjectRouteProviderElement(super.provider);

  @override
  ServiceRouter get service => (origin as ProjectRouteProvider).service;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
