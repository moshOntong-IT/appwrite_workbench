import 'package:dart_appwrite/enums.dart';

List<String>? getIgnores(String runtime) {
  final language = runtime.split('-')[0];

  switch (language) {
    case 'cpp':
      return ['build', 'CMakeFiles', 'CMakeCaches.txt'];
    case 'dart':
      return ['.packages', '.dart_tool'];
    case 'deno':
      return [];
    case 'dotnet':
      return ['bin', 'obj', '.nuget'];
    case 'java':
    case 'kotlin':
      return ['build'];
    case 'node':
    case 'bun':
      return ['node_modules', '.npm'];
    case 'php':
      return ['vendor'];
    case 'python':
      return ['__pypackages__'];
    case 'ruby':
      return ['vendor'];
    case 'rust':
      return ['target', 'debug', '*.rs.bk', '*.pdb'];
    case 'swift':
      return ['.build', '.swiftpm'];
    default:
      return null;
  }
}

extension StringToRuntimeExtension on String {
  Runtime toRuntime() {
    switch (this) {
      case 'node-14.5':
        return Runtime.node145;
      case 'node-16.0':
        return Runtime.node160;
      case 'node-18.0':
        return Runtime.node180;
      case 'node-19.0':
        return Runtime.node190;
      case 'node-20.0':
        return Runtime.node200;
      case 'node-21.0':
        return Runtime.node210;
      case 'php-8.0':
        return Runtime.php80;
      case 'php-8.1':
        return Runtime.php81;
      case 'php-8.2':
        return Runtime.php82;
      case 'php-8.3':
        return Runtime.php83;
      case 'ruby-3.0':
        return Runtime.ruby30;
      case 'ruby-3.1':
        return Runtime.ruby31;
      case 'ruby-3.2':
        return Runtime.ruby32;
      case 'ruby-3.3':
        return Runtime.ruby33;
      case 'python-3.8':
        return Runtime.python38;
      case 'python-3.9':
        return Runtime.python39;
      case 'python-3.10':
        return Runtime.python310;
      case 'python-3.11':
        return Runtime.python311;
      case 'python-3.12':
        return Runtime.python312;
      case 'python-ml-3.11':
        return Runtime.pythonMl311;
      case 'deno-1.40':
        return Runtime.deno140;
      case 'dart-2.15':
        return Runtime.dart215;
      case 'dart-2.16':
        return Runtime.dart216;
      case 'dart-2.17':
        return Runtime.dart217;
      case 'dart-2.18':
        return Runtime.dart218;
      case 'dart-3.0':
        return Runtime.dart30;
      case 'dart-3.1':
        return Runtime.dart31;
      case 'dart-3.3':
        return Runtime.dart33;
      case 'dotnet-3.1':
        return Runtime.dotnet31;
      case 'dotnet-6.0':
        return Runtime.dotnet60;
      case 'dotnet-7.0':
        return Runtime.dotnet70;
      case 'java-8.0':
        return Runtime.java80;
      case 'java-11.0':
        return Runtime.java110;
      case 'java-17.0':
        return Runtime.java170;
      case 'java-18.0':
        return Runtime.java180;
      case 'java-21.0':
        return Runtime.java210;
      case 'swift-5.5':
        return Runtime.swift55;
      case 'swift-5.8':
        return Runtime.swift58;
      case 'swift-5.9':
        return Runtime.swift59;
      case 'kotlin-1.6':
        return Runtime.kotlin16;
      case 'kotlin-1.8':
        return Runtime.kotlin18;
      case 'kotlin-1.9':
        return Runtime.kotlin19;
      case 'cpp-17':
        return Runtime.cpp17;
      case 'cpp-20':
        return Runtime.cpp20;
      case 'bun-1.0':
        return Runtime.bun10;
      case 'go-1.22':
        return Runtime.go122;
      default:
        throw ArgumentError('Unknown runtime code: $this');
    }
  }
}
