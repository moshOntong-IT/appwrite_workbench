import 'dart:async';

import 'package:appwrite_workbench/core/appwrite_client.dart';
import 'package:logging/logging.dart';

class JwtManager {
  static final JwtManager _instance = JwtManager._internal();

  static final Logger _logger = Logger('JwtManager');
  // Private constructor
  JwtManager._internal();

  factory JwtManager() {
    return _instance;
  }

  String? userJwt;
  String? functionJwt;

  Timer? timerWarn;
  Timer? timerError;

  Future<void> setup({
    required AppwriteClient client,
    String? userId,
    List<String> projectScopes = const [],
    Function(String message)? log,
  }) async {
    timerWarn?.cancel();
    timerError?.cancel();

    timerWarn = Timer(const Duration(minutes: 55), () {
      const warningMessage =
          "Warning: Authorized JWT will expire in 5 minutes. Please stop and re-run the command to refresh tokens for 1 hour.";
      _logger.warning(
        warningMessage,
      );

      log?.call(
        warningMessage,
      );
    });

    timerError = Timer(const Duration(hours: 1), () {
      _logger.severe(
        "Authorized JWT expired. Please stop and re-run the command to obtain new tokens with 1 hour validity.",
      );
      _logger.severe("Some Appwrite API communication is not authorized now.");
      log?.call(
          "Warning: Authorized JWT just expired. Please stop and re-run the command to obtain new tokens with 1 hour validity.");
      log?.call("Some Appwrite API communication is not authorized now.");
    });

    if (userId != null) {
      await client.users.get(userId: userId);
      final userResponse = await client.users.createJWT(
        userId: userId,
        duration: 60 * 60,
      );
      userJwt = userResponse.jwt;
    }

    // ! Need to find alterantive for this
    // // Fetch function JWT
    // var functionResponse = await projectsCreateJWT(
    //   projectId: localConfig.getProject().projectId,
    //   scopes: projectScopes,
    //   duration: 60 * 60,
    // );
    // functionJwt = functionResponse['jwt'];
  }
}
