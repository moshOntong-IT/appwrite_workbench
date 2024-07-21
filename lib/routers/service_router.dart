import 'package:appwrite_workbench/services/preference_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

final serviceRouterProvider = ChangeNotifierProvider<ServiceRouter>((ref) {
  return ServiceRouter(
    ref: ref,
  );
});

/// {@template router_service_base}
/// A base class for the router service.
/// {@endtemplate}
class ServiceRouter extends ChangeNotifier {
  ServiceRouter({
    required this.ref,
  });

  final Ref ref;

  static final Logger _logger = Logger('ServiceRouter');
  bool _isLogin = false;
  bool _isFirstTime = PreferenceService.instance.isFirstTime();
  bool _isSetup = PreferenceService.instance.isSetup();

  bool get login => _isLogin;
  bool get isSetup => _isSetup;
  bool get isFirstTime => _isFirstTime;

  set login(bool isLogin) {
    _isLogin = isLogin;

    notifyListeners();
  }

  set isFirstTime(bool isFirstTime) {
    _isFirstTime = isFirstTime;
    PreferenceService.instance.setFirstTime(isFirstTime);
    notifyListeners();
  }

  set isSetup(bool isSetup) {
    _isSetup = isSetup;
    PreferenceService.instance.setSetup(isSetup);
    notifyListeners();
  }

  /// It sets the onboarding value.
  // Future<void> setOnboarded({required bool value});

  /// It sets the onboarding value.
  Future<void> onAppStart({void Function(bool success)? onDone}) async {
    _logger.info('Initializing App...');

    onDone?.call(true);

    _logger.info('App Initialized');
  }
}
