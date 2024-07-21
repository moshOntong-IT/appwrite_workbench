// Dart

// Define a PreferenceService class as a singleton
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';

class PreferenceService {
  // Private constructor
  PreferenceService._privateConstructor();

  // The single instance of PreferenceService
  static final PreferenceService _instance =
      PreferenceService._privateConstructor();

  static final Logger _logger = Logger('PreferenceService');
  // Getter to access the single instance
  static PreferenceService get instance => _instance;

  late Box<dynamic> preferenceBox;
  bool isInitialized = false;

  Future<void> initialize({required Box<dynamic> preferenceBox}) async {
    _logger.info('Initializing PreferenceService');
    this.preferenceBox = preferenceBox;

    isInitialized = true;
  }

  bool isSetup() {
    assert(isInitialized, 'PreferenceService is not initialized');
    _logger.info('Checking if setup');
    final value = preferenceBox.get('setup', defaultValue: false);

    _logger.info('Setup is $value');

    return value;
  }

  Future<bool> setSetup(bool value) async {
    assert(isInitialized, 'PreferenceService is not initialized');
    _logger.info('Setting setup to $value');

    await preferenceBox.put('setup', value);

    _logger.fine('Setup set to $value');

    return true;
  }

  bool isFirstTime() {
    assert(isInitialized, 'PreferenceService is not initialized');
    _logger.info('Checking if first time');
    final value = preferenceBox.get('firstTime', defaultValue: true);

    _logger.info('First time is $value');

    return value;
  }

  Future<bool> setFirstTime(bool value) async {
    assert(isInitialized, 'PreferenceService is not initialized');
    _logger.info('Setting first time to $value');

    await preferenceBox.put('firstTime', value);

    _logger.fine('First time set to $value');

    return true;
  }
}
