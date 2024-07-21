import 'package:appwrite_workbench/routers/app_router.dart';
import 'package:appwrite_workbench/routers/service_router.dart';
import 'package:appwrite_workbench/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.instance.initialize();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return ToastificationWrapper(
      child: ShadApp.router(
        themeMode: ThemeMode.dark,
        routerConfig: appRouter.config(
          reevaluateListenable: ref.watch(serviceRouterProvider),
        ),
      ),
    );
  }
}
