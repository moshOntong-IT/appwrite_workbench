import 'package:appwrite_workbench/features/functions/presentation/widgets/functions_headbar_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class FunctionsScreen extends ConsumerWidget {
  const FunctionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _Main();
  }
}

class _Main extends ConsumerWidget {
  const _Main();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        FunctionsHeadbarWidget(),
      ],
    );
  }
}
