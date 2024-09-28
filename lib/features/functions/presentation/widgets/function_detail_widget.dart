import 'package:appwrite_workbench/features/functions/presentation/widgets/function_environment_widget.dart';
import 'package:appwrite_workbench/features/functions/presentation/widgets/function_information_widget.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FunctionDetailWidget extends ConsumerWidget {
  const FunctionDetailWidget({
    required this.function,
    super.key,
  });
  final FunctionWorkbench function;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ShadSheet(
      closeIcon: const SizedBox.shrink(),
      constraints: const BoxConstraints(
        minWidth: 500,
        maxWidth: 500,
      ),
      title: Row(
        children: [
          ShadButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            height: 24,
            width: 24,
            icon: const Icon(
              LucideIcons.x,
              size: 16,
            ),
          ),
          const Gap(8),
          Text(function.name),
        ],
      ),
      description: Text(function.$id),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ShadButton(
                    onPressed: () {},
                    icon: const Icon(
                      LucideIcons.arrowDownToLine,
                      size: 16,
                    ),
                    child: const Text('Pull'),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: ShadButton(
                    onPressed: () {},
                    icon: const Icon(
                      LucideIcons.arrowUpToLine,
                      size: 16,
                    ),
                    child: const Text('Push'),
                  ),
                ),
              ],
            ),
            const Gap(8),
            const ShadButton.outline(
              icon: Icon(
                LucideIcons.folder,
                size: 16,
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Gap(8),
                  Text('Reveal in Directory'),
                ],
              ),
            ),
            const Gap(8),
            const ShadButton.outline(
              foregroundColor: Colors.blue,
              icon: ShadImage(
                'assets/icons/vscode.png',
                height: 16,
                width: 16,
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Gap(8),
                  Text('Open Vscode'),
                ],
              ),
            ),
            const Gap(8),
            const _Tabs(),
          ],
        ),
      ),
    );
  }
}

class _Tabs extends ConsumerWidget {
  const _Tabs();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ShadTabs<String>(
      value: 'information',
      tabs: [
        ShadTab(
          value: 'information',
          content: FunctionInformationWidget(),
          child: Text('Detail'),
        ),
        ShadTab(
          value: 'env',
          content: FunctionEnvironmentWidget(),
          child: Text('Environment Variables'),
        ),
      ],
    );
  }
}
