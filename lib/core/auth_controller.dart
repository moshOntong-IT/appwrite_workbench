import 'dart:convert';
import 'package:appwrite_workbench/routers/service_router.dart';
import 'package:appwrite_workbench/services/local_storage_service.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthController extends ChangeNotifier {
  static final provider =
      ChangeNotifierProvider((ref) => AuthController(ref: ref));
  AuthController({required this.ref});
  final Ref ref;

  Future<void> loginNotify({
    required String username,
    required String password,
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    try {
      final secretBox = LocalStorageService.instance.secretBox;

      if (secretBox == null) {
        onError();
        return;
      }

      final storedData = secretBox.get(username) as String?;
      if (storedData == null) {
        onError();
        return;
      }

      final jsonData = jsonDecode(storedData);
      final encryptedData = jsonData['encrypted'] as String;
      final iv = encrypt.IV.fromBase64(jsonData['iv'] as String);

      const encryptionKey = FlutterSecureStorage();

      final key = await encryptionKey.read(key: 'key');
      if (key == null) {
        onError();
        return;
      }

      final formattedKey = base64Url.decode(key);
      final encrypter = encrypt.Encrypter(
        encrypt.AES(
          encrypt.Key(formattedKey),
          mode: encrypt.AESMode.cbc,
        ),
      );

      debugPrint('Decryption Key: $key');
      debugPrint('IV: ${iv.base16}');

      final decrypted = encrypter.decrypt(
        encrypt.Encrypted.fromBase64(encryptedData),
        iv: iv,
      );

      if (decrypted == password) {
        ref.read(serviceRouterProvider).login = true;
        onSuccess();
      } else {
        onError();
      }
    } catch (e) {
      debugPrint('Error during login: $e');
      onError();
    } finally {
      notifyListeners();
    }
  }

  Future<void> setupNotify({
    required String username,
    required String password,
    required VoidCallback onSuccessfull,
    required VoidCallback onError,
  }) async {
    try {
      const secureStorage = FlutterSecureStorage();
      await secureStorage.deleteAll(); // Ensure no old keys remain
      final encryptionKey = await secureStorage.read(key: 'key');

      if (encryptionKey != null) {
        throw Exception('Key already exists');
      }

      final key = Hive.generateSecureKey(); // Generate a secure key
      final encodedKey = base64Url.encode(key); // Encode the key in base64
      await secureStorage.write(
        key: 'key',
        value: encodedKey,
      );

      final iv = encrypt.IV.fromLength(16); // Generate a random IV
      final encrypter = encrypt.Encrypter(
        encrypt.AES(
          encrypt.Key.fromBase64(encodedKey),
          mode: encrypt.AESMode.cbc,
        ),
      );

      debugPrint('Encryption Key: $encodedKey');
      debugPrint('IV: ${iv.base16}');

      final encrypted = encrypter.encrypt(password, iv: iv);

      final secretBox = await LocalStorageService.instance.setUpSecretBox();

      // Store the IV along with the encrypted data
      await secretBox.put(
        username,
        jsonEncode({
          'iv': iv.base64,
          'encrypted': encrypted.base64,
        }),
      );

      // await LocalStorageService.instance.preferenceBox.put('setup', true);

      ref.read(serviceRouterProvider).isSetup = true;

      onSuccessfull.call();
    } catch (__, _) {
      onError.call();
    } finally {
      notifyListeners();
    }
  }
}
