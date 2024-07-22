import 'package:appwrite_workbench/core/runtime_enum_extensions.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/models/service.dart';
import 'package:dart_appwrite/models.dart';
import 'package:isar/isar.dart';

part 'function.g.dart';

sealed class FunctionWorkbench extends ServiceWorkbench {
  late String $id;
  late String name;
  late String runtime;
  List<String>? execute;
  List<String>? events;
  String? schedule;
  int? timeout;
  bool? enabled;
  bool? logging;
  String? entrypoint;
  String? commands;
  List<String>? ignore;
  bool? live;
  String? deployment;
  List<String>? scopes;
  String? version;
  String? installationId;
  String? providerRepositoryId;
  String? providerBranch;
  String? providerRootDirectory;
  bool? providerSilentMode;
}

@collection
class FunctionApi extends FunctionWorkbench {
  FunctionApi() : syncedAt = DateTime.now();

  @Name(r'$syncedAt')
  final DateTime syncedAt;

  final projects = IsarLinks<ProjectApi>();

  factory FunctionApi.fromJson(Func func) {
    return FunctionApi()
      ..$id = func.$id
      ..name = func.name
      ..runtime = func.runtime
      ..execute = List<String>.from(func.execute)
      ..events = List<String>.from(func.events)
      ..schedule = func.schedule
      ..timeout = func.timeout
      ..enabled = func.enabled
      ..logging = func.logging
      ..entrypoint = func.entrypoint
      ..commands = func.commands
      ..live = func.live
      ..deployment = func.deployment
      ..scopes = List<String>.from(func.scopes)
      ..version = func.version
      ..installationId = func.installationId
      ..providerRepositoryId = func.providerRepositoryId
      ..providerBranch = func.providerBranch
      ..providerRootDirectory = func.providerRootDirectory
      ..providerSilentMode = func.providerSilentMode
      ..ignore = getIgnores(func.$id);
  }
}

class FunctionJson extends FunctionWorkbench {
  FunctionJson();
  late final String path;

  factory FunctionJson.fromJson(Map<String, dynamic> json) {
    return FunctionJson()
      ..$id = json[r'$id'] as String
      ..name = json['name'] as String
      ..runtime = json['runtime'] as String
      ..execute = List<String>.from(json['execute'] as List)
      ..events = List<String>.from(json['events'] as List)
      ..schedule = json['schedule'] as String
      ..timeout = json['timeout'] as int
      ..enabled = json['enabled'] as bool
      ..logging = json['logging'] as bool
      ..entrypoint = json['entrypoint'] as String
      ..commands = json['commands'] as String
      ..ignore = List<String>.from(json['ignore'] as List)
      ..live = json['live'] as bool
      ..deployment = json['deployment'] as String
      ..scopes = List<String>.from(json['scopes'] as List)
      ..version = json['version'] as String
      ..installationId = json['installationId'] as String
      ..providerRepositoryId = json['providerRepositoryId'] as String
      ..providerBranch = json['providerBranch'] as String
      ..providerRootDirectory = json['providerRootDirectory'] as String
      ..providerSilentMode = json['providerSilentMode'] as bool
      ..path = json['path'] as String;
  }
}
