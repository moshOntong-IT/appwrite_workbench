import 'package:isar/isar.dart';

class ServiceWorkbench {
  ServiceWorkbench()
      : createdAt = DateTime.now(),
        updatedAt = DateTime.now();
  Id id = Isar.autoIncrement;

  @Name(r'$createdAt')
  DateTime createdAt;

  @Name(r'$updatedAt')
  DateTime updatedAt;
}
