import 'dart:io';

import 'package:process_run/process_run.dart';

Future<bool> isPortTaken(int port) async {
  try {
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, port);
    await server.close();
    return false;
  } catch (e) {
    return true;
  }
}

Future<bool> systemHasCommand(String command) async {
  final shell = Shell();

  try {
    await (Platform.isWindows
        ? shell.run('where $command')
        : shell.run('command -v $command'));
  } catch (e) {
    return false;
  }

  return true;
}
