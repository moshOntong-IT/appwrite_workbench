import 'package:appwrite_workbench/features/functions/presentation/create_function_dialog.dart';
import 'package:appwrite_workbench/global_providars.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FunctionsHeadbarWidget extends ConsumerWidget {
  const FunctionsHeadbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ShadTheme.of(context).colorScheme.accent,
        border: Border(
          bottom: BorderSide(
            color: ShadTheme.of(context).colorScheme.mutedForeground,
            width: 1,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 20,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Functions',
                style: ShadTheme.of(context).textTheme.h1Large,
              ),
            ),
          ),
          const Positioned(
            bottom: 20,
            right: 20,
            child: _Actions(),
          )
        ],
      ),
    );
  }
}

class _Actions extends ConsumerWidget {
  const _Actions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      children: [
        _CreateFunction(),
      ],
    );
  }
}

class _CreateFunction extends ConsumerWidget {
  const _CreateFunction();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectSelectedProvider);
    return ShadButton(
      size: ShadButtonSize.sm,
      icon: const ShadImage.square(
        size: 16,
        LucideIcons.plus,
      ),
      child: const Text(
        'Create Function',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      onPressed: () {
        if (project is ProjectApi) {
          showShadDialog(
            context: context,
            builder: (context) => CreateFunctionDialog(
              project: project,
              client: ref.read(appwriteClientProvider),
            ),
          );
        }
      },
    );
  }
}
