import 'package:appwrite_workbench/models/project.dart';
import 'package:dart_appwrite/dart_appwrite.dart';

class AppwriteClient {
  AppwriteClient({
    required this.projectApi,
    required this.apiKey,
  }) {
    client = Client()
        .setEndpoint(projectApi.endpoint)
        .setProject(projectApi.projectId)
        .setKey(apiKey);
    account = Account(client);
    databases = Databases(client);
    users = Users(client);
    storage = Storage(client);
    functions = Functions(client);
  }
  final ProjectApi projectApi;
  final String apiKey;

  late final Client client;
  late final Account account;
  late final Databases databases;
  late final Users users;
  late final Storage storage;
  late final Functions functions;
}
