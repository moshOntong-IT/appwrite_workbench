import 'dart:async';
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:process_run/process_run.dart';

import 'package:path/path.dart' as p;

class DockerRuntimeService {
  // Singleton instance
  static final DockerRuntimeService _instance =
      DockerRuntimeService._internal();

  // Private constructor
  DockerRuntimeService._internal();

  // Factory constructor to return the singleton instance
  factory DockerRuntimeService() {
    return _instance;
  }

  static final Logger _logger = Logger('DockerRuntimeService');

  final Shell _shell = Shell();

  Future<void> dockerStop(String id) async {
    try {
      await _shell.run('docker rm --force $id');
      _logger.info('Docker container $id stopped.');
    } catch (e) {
      _logger.severe('Error stopping Docker container $id: $e');
    }
  }

  Future<void> dockerPull(Map<String, dynamic> func) async {
    String runtime = func['runtime'];
    List<String> runtimeChunks = runtime.split('-');
    String runtimeVersion = runtimeChunks.removeLast();
    String runtimeName = runtimeChunks.join('-');
    String imageName = 'openruntimes/$runtimeName:v4-$runtimeVersion';

    _logger.info('Pulling Docker image $imageName...');

    try {
      await _shell.run('docker pull $imageName');
    } catch (e) {
      _logger.severe('Error pulling Docker image $imageName: $e');
    }
  }

  Future<void> dockerBuild(
      Map<String, dynamic> func, Map<String, String> variables) async {
    String runtime = func['runtime'];
    List<String> runtimeChunks = runtime.split('-');
    String runtimeVersion = runtimeChunks.removeLast();
    String runtimeName = runtimeChunks.join('-');
    String imageName = 'openruntimes/$runtimeName:v4-$runtimeVersion';

    String functionDir = p.join(Directory.current.path, func['path']);
    String id = func['\$id'];
    String tmpBuildPath = p.join(functionDir, '.appwrite/tmp-build');

    // Prepare build folder
    await Directory(tmpBuildPath).create(recursive: true);
    await _copyFiles(functionDir, tmpBuildPath);

    List<String> params = [
      'docker',
      'run',
      '--name',
      id,
      '-v',
      '$tmpBuildPath:/mnt/code:rw',
      '-e',
      'OPEN_RUNTIMES_ENV=development',
      '-e',
      'OPEN_RUNTIMES_SECRET=',
      '-e',
      'OPEN_RUNTIMES_ENTRYPOINT=${func['entrypoint']}'
    ];

    variables.forEach((key, value) {
      params.add('-e');
      params.add('$key=$value');
    });

    params.addAll(
        [imageName, 'sh', '-c', 'helpers/build.sh "${func['commands']}"']);

    await _executeCommand(params, functionDir, id);

    // Clean up
    String copyPath = p.join(functionDir, '.appwrite/build.tar.gz');
    await Directory(p.dirname(copyPath)).create(recursive: true);
    await _shell.run('docker cp $id:/mnt/code/code.tar.gz $copyPath');
    await dockerStop(id);
    await Directory(tmpBuildPath).delete(recursive: true);
  }

  Future<void> dockerStart(Map<String, dynamic> func,
      Map<String, String> variables, int port) async {
    String functionDir = p.join(Directory.current.path, func['path']);
    List<String> runtimeChunks = func['runtime'].split('-');
    String runtimeVersion = runtimeChunks.removeLast();
    String runtimeName = runtimeChunks.join('-');
    String imageName = 'openruntimes/$runtimeName:v4-$runtimeVersion';
    String id = func['\$id'];

    List<String> params = [
      'docker',
      'run',
      '--rm',
      '--name',
      id,
      '-p',
      '$port:3000',
      '-e',
      'OPEN_RUNTIMES_ENV=development',
      '-e',
      'OPEN_RUNTIMES_SECRET=',
      '-v',
      '$functionDir/.appwrite/logs.txt:/mnt/logs/dev_logs.log:rw',
      '-v',
      '$functionDir/.appwrite/errors.txt:/mnt/logs/dev_errors.log:rw',
      '-v',
      '$functionDir/.appwrite/build.tar.gz:/mnt/code/code.tar.gz:ro'
    ];

    variables.forEach((key, value) {
      params.add('-e');
      params.add('$key=$value');
    });

    params.addAll(
        [imageName, 'sh', '-c', 'helpers/start.sh "${func['commands']}"']);

    await _executeCommand(params, functionDir, id);
    _logger.finest('Visit http://localhost:$port/ to execute your function.');
  }

  Future<void> dockerCleanup(String functionId) async {
    await dockerStop(functionId);

    String funcPath = p.join(Directory.current.path, functionId);
    String appwritePath = p.join(funcPath, '.appwrite');
    String tempPath = p.join(funcPath, 'code.tar.gz');

    if (await Directory(appwritePath).exists()) {
      await Directory(appwritePath).delete(recursive: true);
    }
    if (await File(tempPath).exists()) {
      await File(tempPath).delete();
    }
  }

  Future<void> _copyFiles(String sourceDir, String targetDir) async {
    final sourceDirectory = Directory(sourceDir);
    final targetDirectory = Directory(targetDir);

    if (!await targetDirectory.exists()) {
      await targetDirectory.create(recursive: true);
    }

    await for (var entity
        in sourceDirectory.list(recursive: true, followLinks: false)) {
      if (entity is File) {
        String newPath = entity.path.replaceFirst(sourceDir, targetDir);
        await File(newPath).create(recursive: true);
        await entity.copy(newPath);
      }
    }
  }

  Future<void> _executeCommand(
    List<String> params,
    String workingDirectory,
    String id,
  ) async {
    try {
      await _shell.cd(workingDirectory).run(params.join(' '));
    } catch (e) {
      _logger.severe('Error executing Docker command for $id: $e');
    }
  }
}

// void main() async {
//   DockerRuntimeService dockerService = DockerRuntimeService();

//   // Example usage
//   Map<String, dynamic> func = {
//     'runtime': 'node-14',
//     '\$id': 'exampleId',
//     'path': 'path/to/your/function',
//     'entrypoint': 'src/server.js',
//     'commands': 'npm install',
//   };

//   await dockerService.dockerPull(func);
// }
