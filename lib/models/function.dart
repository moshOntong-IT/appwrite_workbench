import 'package:appwrite_workbench/models/service.dart';
import 'package:isar/isar.dart';

sealed class FunctionWorkbench extends ServiceWorkbench {
  late String $id;
  late String name;
  late String runtime;
  late List<String> execute;
  late List<String> events;
  late String schedule;
  late int timeout;
  late bool enabled;
  late bool logging;
  late String entrypoint;
  late String commands;
  late List<String> ignore;
}

@collection
class FunctionApi extends FunctionWorkbench {
  FunctionApi() : syncedAt = DateTime.now();

  @Name(r'$syncedAt')
  final DateTime syncedAt;
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
      ..path = json['path'] as String;
  }
}
