import 'dart:convert';
import 'dart:io';

import 'package:appwrite_workbench/core/appwrite_workbench_code.dart';
import 'package:appwrite_workbench/models/appwrite_workbench_exception.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/services/preference_service.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  static final Logger _logger = Logger('LocalStorageService');
  late final String _base;

  bool _isInitialized = false;
  late final Isar _isar;

  Box<dynamic>? secretBox;

  bool _isSetup = false;
  bool _isSecretBoxInitialized = false;

  // Getter instance
  static LocalStorageService get instance => _instance;
  static bool get isSetup => _instance._isSetup;
  static Isar get isar => _instance._isar;
  static String get base => _instance._base;
  Future<void> initialize() async {
    _logger.info('Initializing LocalStorageService');
    if (_isInitialized) return;

    _logger.info('Initializing Hive');
    final dir = await getApplicationDocumentsDirectory();
    _logger.info('Directory: ${dir.path}');
    final base = await _getOrCreateDirectory(dir.path, 'appwrite_workbench');
    _logger.info('Base: $base');
    _base = base;
    await Hive.initFlutter(base);
    _logger.info('Hive initialized');

    _logger.info('Opening Isar');
    _isar = await Isar.open(
      [
        ProjectApiSchema,
        ProjectJsonSchema,
        FunctionApiSchema,
      ],
      directory: base,
    );

    _logger.finest('Isar opened');

    _logger.info('Opening Hive boxes');
    final preferenceBox = await Hive.openBox('preferences');
    await PreferenceService.instance.initialize(preferenceBox: preferenceBox);

    _isSetup = PreferenceService.instance.isSetup();

    if (_isSetup) {
      _logger.info('Opening secret box');
      // const secureStorage = FlutterSecureStorage();
      // final encryptionKey = await secureStorage.read(key: 'key');

      // if (encryptionKey != null) {
      //   final encryptionKeyUint8List = base64Url.decode(encryptionKey);
      //   secretBox = await Hive.openBox<dynamic>(
      //     'secret',
      //     encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
      //   );
      // }
      secretBox = await setUpSecretBox();
      _logger.finest('Secret box opened');
    }

    // Hive.registerAdapter<Project>('Project', Project.fromJson);

    _isInitialized = true;
    _logger.finest('LocalStorageService initialized');
  }

  Future<Box<dynamic>> setUpSecretBox() async {
    if (_isSecretBoxInitialized) {
      return secretBox!;
    }
    const secureStorage = FlutterSecureStorage();
    final encryptionKey = await secureStorage.read(key: 'key');

    if (encryptionKey != null) {
      final encryptionKeyUint8List = base64Url.decode(encryptionKey);
      secretBox = await Hive.openBox<dynamic>(
        'secret',
        encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
      );
    }

    _isSecretBoxInitialized = true;

    return secretBox!;
  }

  Future<void> addKey({required String projectId, required String key}) async {
    _logger.info('Adding key for project: $projectId');
    assert(secretBox != null, 'Secret box is not initialized');
    if (secretBox != null) {
      _logger.info('Putting key in secret box');
      await secretBox!.put(projectId, key);
      _logger.finest('Key put in secret box');
    } else {
      _logger.severe('Secret box is not initialized');
    }
  }

  String getKey({required String projectId}) {
    _logger.info('Getting key for project: $projectId');
    assert(secretBox != null, 'Secret box is not initialized');
    if (secretBox != null) {
      _logger.info('Getting key from secret box');
      return secretBox!.get(projectId) as String;
    } else {
      _logger.severe('Secret box is not initialized');
      throw AppwriteWorkbenchException(
        message: 'Secret box is not initialized',
        code: AppwriteWorkbenchExceptionCode.notFound,
        stackTrace: StackTrace.current,
      );
    }
  }

  List<Variable> getVars({
    required String projectId,
    required String functionId,
  }) {
    _logger.info('Getting vars for project: $projectId');
    assert(secretBox != null, 'Secret box is not initialized');
    if (secretBox != null) {
      _logger.info('Getting vars from secret box');
      final vars = secretBox!.get('$projectId-$functionId-vars');
      _logger.finest('Vars: $vars');
      final varsConverted = (vars as List<dynamic>?)
          ?.map((e) => Variable.fromMap(e as Map<String, dynamic>))
          .toList();

      return varsConverted ?? [];
    } else {
      _logger.severe('Secret box is not initialized');
      throw AppwriteWorkbenchException(
        message: 'Secret box is not initialized',
        code: AppwriteWorkbenchExceptionCode.notFound,
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<Variable> createVar({
    required String projectId,
    required String functionId,
    required String key,
    required String value,
  }) async {
    _logger.info('Creating var for function: $functionId');

    final newVar = Variable(
      $id: ID.unique(),
      $createdAt: DateTime.now().toIso8601String(),
      $updatedAt: DateTime.now().toIso8601String(),
      key: key,
      value: value,
      resourceType: 'function',
      resourceId: functionId,
    );

    assert(secretBox != null, 'Secret box is not initialized');

    if (secretBox != null) {
      _logger.info('Getting vars from secret box');
      final vars = secretBox!.get('$projectId-$functionId-vars');
      _logger.finest('Vars: $vars');
      final varsConverted = (vars as List<dynamic>?)
          ?.map((e) => Variable.fromMap(e as Map<String, dynamic>))
          .toList();

      final newVars = [...varsConverted ?? [], newVar];

      await secretBox!.put('$projectId-$functionId-vars',
          newVars.map((e) => e.toMap()).toList());

      return newVar;
    } else {
      _logger.severe('Secret box is not initialized');
      throw AppwriteWorkbenchException(
        message: 'Secret box is not initialized',
        code: AppwriteWorkbenchExceptionCode.notFound,
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<Variable> updateVar({
    required String projectId,
    required String functionId,
    required String key,
    required String value,
  }) async {
    _logger.info('Updating var for function: $functionId');

    assert(secretBox != null, 'Secret box is not initialized');

    if (secretBox != null) {
      _logger.info('Getting vars from secret box');
      final vars = secretBox!.get('$projectId-$functionId-vars');
      _logger.finest('Vars: $vars');
      final varsConverted = (vars as List<dynamic>?)
          ?.map((e) => Variable.fromMap(e as Map<String, dynamic>))
          .toList();

      final newVars = varsConverted?.map((e) {
        if (e.key == key) {
          final variable = Variable(
            $id: e.$id,
            $createdAt: e.$createdAt,
            $updatedAt: DateTime.now().toIso8601String(),
            key: key,
            value: value,
            resourceType: e.resourceType,
            resourceId: e.resourceId,
          );

          return variable;
        }
        return e;
      }).toList();

      if (newVars != null) {
        await secretBox!.put('$projectId-$functionId-vars',
            newVars.map((e) => e.toMap()).toList());

        return newVars.firstWhere((element) => element.key == key);
      }

      throw AppwriteWorkbenchException(
        message: 'Variable not found',
        code: AppwriteWorkbenchExceptionCode.notFound,
        stackTrace: StackTrace.current,
      );
    } else {
      _logger.severe('Secret box is not initialized');
      throw AppwriteWorkbenchException(
        message: 'Secret box is not initialized',
        code: AppwriteWorkbenchExceptionCode.notFound,
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> deleteVar({
    required String projectId,
    required String functionId,
    required String key,
  }) async {
    _logger.info('Deleting var for function: $functionId');

    assert(secretBox != null, 'Secret box is not initialized');

    if (secretBox != null) {
      _logger.info('Getting vars from secret box');
      final vars = secretBox!.get('$projectId-$functionId-vars');
      _logger.finest('Vars: $vars');
      final varsConverted = (vars as List<dynamic>?)
          ?.map((e) => Variable.fromMap(e as Map<String, dynamic>))
          .toList();

      final newVars = varsConverted?.where((e) => e.key != key).toList();

      if (newVars != null) {
        await secretBox!.put('$projectId-$functionId-vars',
            newVars.map((e) => e.toMap()).toList());
      }
    } else {
      _logger.severe('Secret box is not initialized');
      throw AppwriteWorkbenchException(
        message: 'Secret box is not initialized',
        code: AppwriteWorkbenchExceptionCode.notFound,
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> setVars({
    required String projectId,
    required String functionId,
    required List<Variable> vars,
  }) async {
    _logger.info('Setting vars for project: $projectId');
    assert(secretBox != null, 'Secret box is not initialized');
    if (secretBox != null) {
      _logger.info('Setting vars in secret box');
      await secretBox!.put(
          '$projectId-$functionId-vars', vars.map((e) => e.toMap()).toList());
      _logger.finest('Vars set in secret box');
    } else {
      _logger.severe('Secret box is not initialized');
      throw AppwriteWorkbenchException(
        message: 'Secret box is not initialized',
        code: AppwriteWorkbenchExceptionCode.notFound,
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<String> _getOrCreateDirectory(String basePath, String subDir) async {
    _logger.info('Getting or creating directory: $subDir');
    final directory = Directory('$basePath/$subDir');
    _logger.finest('Directory: ${directory.path}');
    if (!(await directory.exists())) {
      _logger.info('Creating directory: $subDir');
      await directory.create(recursive: true);
      _logger.finest('Directory created: $subDir');
    } else {
      _logger.finest('Directory already exists: $subDir');
    }
    return directory.path;
  }
}
