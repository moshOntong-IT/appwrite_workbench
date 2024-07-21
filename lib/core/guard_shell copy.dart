// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:logger/logger.dart' as pretty_logger;
import 'package:logging/logging.dart';

/// Runs [mainFunction] in a guarded [Zone].
///
/// If a non-null [FirebaseCrashlytics] instance is provided through
/// [crashlytics], then all errors will be reported through it.
///
/// These errors will also include latest logs from anywhere in the app
/// that use `package:logging`.
Future<void> guardShell(void Function() mainFunction) async {
  // Running the initialization code and [mainFunction] inside a guarded
  // zone, so that all errors (even those occurring in callbacks) are
  // caught and can be sent to Crashlytics.
  // await runZonedGuarded<Future<void>>(() async {

  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn =
  //         'https://cac7460d5f076f873becb0fc7181b58f@o4507491826270208.ingest.de.sentry.io/4507491961733200';

  //     if (!kDebugMode) {
  //       // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
  //       // We recommend adjusting this value in production.
  //       options.tracesSampleRate = 0.1;
  //       // The sampling rate for profiling is relative to tracesSampleRate
  //       // Setting to 1.0 will profile 100% of sampled transactions:
  //       options.profilesSampleRate = 0.1;
  //     }
  //   },
  // );
  final prettyLog = pretty_logger.Logger(
    printer: pretty_logger.PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  // Subscribe to log messages.
  Logger.root.onRecord.listen((record) {
    final message = '${record.level.name}: ${record.time}: '
        '${record.loggerName}: '
        '${record.message}';

    _debugLogger(prettyLog,
        record: record,
        time: record.time,
        message: message,
        error: record.error,
        stackTrace: record.stackTrace);

    // if (record.level == Level.SEVERE && !kDebugMode) {
    //   Sentry.captureException(
    //     jsonEncode({
    //       'message': message,
    //       'error': record.error.toString(),
    //     }),
    //     stackTrace: record.stackTrace ?? StackTrace.current,
    //   );
    // }
  });

  // FlutterError.onError = (details) {
  //   prettyLog.e('FlutterError.onError: ${details.exception}',
  //       error: details.exception, stackTrace: details.stack);
  //   Sentry.captureException(
  //     details.exception,
  //     stackTrace: details.stack,
  //   );
  // };

  // PlatformDispatcher.instance.onError = (errorDetails, stackTrace) {
  //   if (!kDebugMode) {
  //     Sentry.captureException(
  //       errorDetails,
  //       stackTrace: stackTrace,
  //     );
  //   }
  //   return true;
  // };

  // if (!kIsWeb) {
  //   Isolate.current.addErrorListener(RawReceivePort((pair) async {
  //     final List<dynamic> errorAndStacktrace = pair;
  //     final error = errorAndStacktrace[0];
  //     final stackTrace = errorAndStacktrace[1];
  //     prettyLog.e('Isolate error: $error',
  //         error: error, stackTrace: stackTrace);
  //     if (!kDebugMode) {
  //       Sentry.captureException(
  //         error,
  //         stackTrace: stackTrace,
  //       );
  //     }
  //   }).sendPort);
  // }

  // Run the actual code.
  mainFunction();
  // }, (error, stack) {
  //   // This sees all errors that occur in the runZonedGuarded zone.
  //   debugPrint('ERROR: $error\n\n'
  //       'STACK:$stack');
  //   crashlytics?.recordError(error, stack, fatal: true);
  // });
}

void _debugLogger(pretty_logger.Logger prettyLog,
    {required LogRecord record,
    required DateTime time,
    required String message,
    Object? error,
    StackTrace? stackTrace}) {
  if (record.level == Level.FINE) {
    prettyLog.d(message, time: time, error: error, stackTrace: stackTrace);
  } else if (record.level == Level.INFO) {
    prettyLog.i(message, time: time, error: error, stackTrace: stackTrace);
  } else if (record.level == Level.WARNING) {
    prettyLog.w(message, time: time, error: error, stackTrace: stackTrace);
  } else if (record.level == Level.SEVERE) {
    prettyLog.e(message, time: time, error: error, stackTrace: stackTrace);
  } else if (record.level == Level.SHOUT) {
    prettyLog.f(message, time: time, error: error, stackTrace: stackTrace);
  }
}

/// Takes a [stackTrace] and creates a new one, but without the lines that
/// have to do with this file and logging. This way, Crashlytics won't group
/// all messages that come from this file into one big heap just because
/// the head of the StackTrace is identical.
///
/// See this:
/// https://stackoverflow.com/questions/47654410/how-to-effectively-group-non-fatal-exceptions-in-crashlytics-fabrics.
@visibleForTesting
StackTrace filterStackTrace(StackTrace stackTrace) {
  try {
    final lines = stackTrace.toString().split('\n');
    final buf = StringBuffer();
    for (final line in lines) {
      if (line.contains('crashlytics.dart') ||
          line.contains('_BroadcastStreamController.java') ||
          line.contains('logger.dart')) {
        continue;
      }
      buf.writeln(line);
    }
    return StackTrace.fromString(buf.toString());
  } catch (e) {
    debugPrint('Problem while filtering stack trace: $e');
  }

  // If there was an error while filtering,
  // return the original, unfiltered stack track.
  return stackTrace;
}
