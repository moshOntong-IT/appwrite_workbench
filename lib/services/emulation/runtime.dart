const openRuntimesVersion = 'v4';

enum RuntimeName {
  node(name: 'Node.js'),
  php(name: 'PHP'),
  ruby(name: 'Ruby'),
  python(name: 'Python'),
  pythonMl(name: 'Python (ML)'),
  deno(name: 'Deno'),
  dart(name: 'Dart'),
  dotnet(name: '.NET'),
  java(name: 'Java'),
  swift(name: 'Swift'),
  kotlin(name: 'Kotlin'),
  bun(name: 'Bun'),
  go(name: 'Go');

  const RuntimeName({required this.name});

  final String name;

  static RuntimeName fromCode(String code) {
    return RuntimeName.values.firstWhere(
        (element) => element.name.toLowerCase() == code.toLowerCase(),
        orElse: () {
      throw ArgumentError("Runtime name '$code' is not defined.");
    });
  }
}

enum RuntimeTool {
  node(
    isCompiled: false,
    startCommand: "node src/server.js",
    dependencyFiles: ["package.json", "package-lock.json"],
  ),
  php(
    isCompiled: false,
    startCommand: "php src/server.php",
    dependencyFiles: ["composer.json", "composer.lock"],
  ),
  ruby(
    isCompiled: false,
    startCommand: "bundle exec puma -b tcp://0.0.0.0:3000 -e production",
    dependencyFiles: ["Gemfile", "Gemfile.lock"],
  ),
  python(
    isCompiled: false,
    startCommand: "python3 src/server.py",
    dependencyFiles: ["requirements.txt", "requirements.lock"],
  ),
  pythonMl(
    isCompiled: false,
    startCommand: "python3 src/server.py",
    dependencyFiles: ["requirements.txt", "requirements.lock"],
  ),
  deno(
    isCompiled: false,
    startCommand: "deno start",
    dependencyFiles: [],
  ),
  dart(
    isCompiled: true,
    startCommand: "src/function/server",
    dependencyFiles: [],
  ),
  dotnet(
    isCompiled: true,
    startCommand: "dotnet src/function/DotNetRuntime.dll",
    dependencyFiles: [],
  ),
  java(
    isCompiled: true,
    startCommand: "java -jar src/function/java-runtime-1.0.0.jar",
    dependencyFiles: [],
  ),
  swift(
    isCompiled: true,
    startCommand:
        "src/function/Runtime serve --env production --hostname 0.0.0.0 --port 3000",
    dependencyFiles: [],
  ),
  kotlin(
    isCompiled: true,
    startCommand: "java -jar src/function/kotlin-runtime-1.0.0.jar",
    dependencyFiles: [],
  ),
  bun(
    isCompiled: false,
    startCommand: "bun src/server.ts",
    dependencyFiles: ["package.json", "package-lock.json", "bun.lockb"],
  ),
  go(
    isCompiled: true,
    startCommand: "src/function/server",
    dependencyFiles: [],
  );

  const RuntimeTool({
    required this.isCompiled,
    required this.startCommand,
    required this.dependencyFiles,
  });

  final bool isCompiled;
  final String startCommand;
  final List<String> dependencyFiles;

  static RuntimeTool fromName(String name) {
    return RuntimeTool.values.firstWhere((element) => element.name == name,
        orElse: () {
      throw ArgumentError("Runtime tool '$name' is not defined.");
    });
  }
}
