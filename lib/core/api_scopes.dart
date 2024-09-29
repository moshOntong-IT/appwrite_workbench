enum ScopeCategory {
  auth(title: 'Auth'),
  database(title: 'Database'),
  functions(title: 'Functions'),
  storage(title: 'Storage'),
  messaging(title: 'Messaging'),
  other(title: 'Other');

  const ScopeCategory({
    required this.title,
  });
  final String title;
}

enum ScopeEnum {
  // !AUTH
  sessionsWrite(
    code: 'sessions.write',
    description: "Access to create, update and delete your project's sessions",
    category: ScopeCategory.auth,
  ),
  usersRead(
    code: 'users.read',
    description: "Access to read your project's users",
    category: ScopeCategory.auth,
  ),
  usersWrite(
    code: 'users.write',
    description: "Access to create, update, and delete your project's users",
    category: ScopeCategory.auth,
  ),
  teamsRead(
    code: 'teams.read',
    description: "Access to read your project's teams",
    category: ScopeCategory.auth,
  ),
  teamsWrite(
    code: 'teams.write',
    description: "Access to create, update, and delete your project's teams",
    category: ScopeCategory.auth,
  ),

  //! DATABASE
  databasesRead(
    code: 'databases.read',
    description: "Access to read your project's databases",
    category: ScopeCategory.database,
  ),
  databasesWrite(
    code: 'databases.write',
    description:
        "Access to create, update, and delete your project's databases",
    category: ScopeCategory.database,
  ),
  collectionsRead(
    code: 'collections.read',
    description: "Access to read your project's database collections",
    category: ScopeCategory.database,
  ),
  collectionsWrite(
    code: 'collections.write',
    description:
        "Access to create, update, and delete your project's database collections",
    category: ScopeCategory.database,
  ),
  attributesRead(
    code: 'attributes.read',
    description:
        "Access to read your project's database collection's attributes",
    category: ScopeCategory.database,
  ),
  attributesWrite(
    code: 'attributes.write',
    description:
        "Access to create, update, and delete your project's database collection's attributes",
    category: ScopeCategory.database,
  ),
  indexRead(
    code: 'indexes.read',
    description: "Access to read your project's database collection's indexes",
    category: ScopeCategory.database,
  ),
  indexWrite(
    code: 'indexes.write',
    description:
        "Access to create, update, and delete your project's database collection's indexes",
    category: ScopeCategory.database,
  ),
  documentsRead(
    code: 'documents.read',
    description: "Access to read your project's database documents",
    category: ScopeCategory.database,
  ),
  documentsWrite(
    code: 'documents.write',
    description:
        "Access to create, update, and delete your project's database documents",
    category: ScopeCategory.database,
  ),

  // !FUNCTIONS
  functionsRead(
    code: 'functions.read',
    description: "Access to read your project's functions and code deployments",
    category: ScopeCategory.functions,
  ),
  functionsWrite(
    code: 'functions.write',
    description:
        "Access to create, update, and delete your project's functions and code deployments",
    category: ScopeCategory.functions,
  ),
  executionRead(
    code: 'execution.read',
    description: "Access to read your project's execution logs",
    category: ScopeCategory.functions,
  ),
  executionWrite(
    code: 'execution.write',
    description: "Access to execute your project's functions",
    category: ScopeCategory.functions,
  ),

  // !STORAGE
  filesRead(
    code: 'files.read',
    description:
        "Access to read your project's storage files and preview images",
    category: ScopeCategory.storage,
  ),
  filesWrite(
    code: 'files.write',
    description:
        "Access to create, update, and delete your project's storage files",
    category: ScopeCategory.storage,
  ),
  bucketsRead(
    code: 'buckets.read',
    description: "Access to read your project's storage buckets",
    category: ScopeCategory.storage,
  ),
  bucketsWrite(
    code: 'buckets.write',
    description:
        "Access to create, update, and delete your project's storage buckets",
    category: ScopeCategory.storage,
  ),

  // !MESSAGING
  targetsRead(
    code: 'targets.read',
    description: "Access to read your project's messaging targets",
    category: ScopeCategory.messaging,
  ),
  targetsWrite(
    code: 'targets.write',
    description:
        "Access to create, update, and delete your project's messaging targets",
    category: ScopeCategory.messaging,
  ),
  providersRead(
    code: 'providers.read',
    description: "Access to read your project's messaging providers",
    category: ScopeCategory.messaging,
  ),
  providersWrite(
    code: 'providers.write',
    description:
        "Access to create, update, and delete your project's messaging providers",
    category: ScopeCategory.messaging,
  ),
  messagesRead(
    code: 'messages.read',
    description: "Access to read your project's messages",
    category: ScopeCategory.messaging,
  ),
  messagesWrite(
    code: 'messages.write',
    description: "Access to create, update, and delete your project's messages",
    category: ScopeCategory.messaging,
  ),
  topicsRead(
    code: 'topics.read',
    description: "Access to read your project's messaging topics",
    category: ScopeCategory.messaging,
  ),
  topicsWrite(
    code: 'topics.write',
    description:
        "Access to create, update, and delete your project's messaging topics",
    category: ScopeCategory.messaging,
  ),
  subscribersRead(
    code: 'subscribers.read',
    description: "Access to read your project's messaging subscribers",
    category: ScopeCategory.messaging,
  ),
  subscribersWrite(
    code: 'subscribers.write',
    description:
        "Access to create, update, and delete your project's messaging subscribers",
    category: ScopeCategory.messaging,
  ),

  // !OTHER
  localeRead(
    code: 'locale.read',
    description: "Access to read your project's locales",
    category: ScopeCategory.other,
  ),
  avatarsRead(
    code: 'avatars.read',
    description: "Access to read your project's avatars",
    category: ScopeCategory.other,
  ),
  healthRead(
    code: 'health.read',
    description: "Access to read your project's health",
    category: ScopeCategory.other,
  ),
  migrationsRead(
    code: 'migrations.read',
    description: "Access to read your project's migrations",
    category: ScopeCategory.other,
  ),
  migrationsWrite(
    code: 'migrations.write',
    description:
        "Access to create, update, and delete your project's migrations",
    category: ScopeCategory.other,
  ),
  ;

  const ScopeEnum({
    required this.code,
    required this.description,
    required this.category,
  });
  final String code;
  final String description;
  final ScopeCategory category;

  static ScopeEnum fromCode(String code) {
    return ScopeEnum.values.firstWhere((element) => element.code == code);
  }
}

extension ScopeEnumX on List<ScopeEnum> {
  List<String> toCodes() => map((e) => e.code).toList();
}
