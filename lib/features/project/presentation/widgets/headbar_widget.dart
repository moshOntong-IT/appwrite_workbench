import 'package:appwrite_workbench/core/provider_scope_extension.dart';
import 'package:appwrite_workbench/features/project/presentation/controllers/headbar_actions_controller.dart';
import 'package:appwrite_workbench/global_providars.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:appwrite_workbench/routers/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:toastification/toastification.dart';

class HeadbarWidget extends ConsumerWidget {
  const HeadbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ShadTheme.of(context).colorScheme.muted,
          ),
        ),
      ),
      child: Row(
        children: [
          const _ProjectInformation(),
          const Spacer(),
          const _SwitchProject(),
          const _OpenDirectory().scope(overrides: [
            headbarActionsControllerProvider
                .overrideWith(HeadbarActionsController.new),
          ]),
          const _OpenCLI().scope(overrides: [
            headbarActionsControllerProvider
                .overrideWith(HeadbarActionsController.new),
          ]),
        ],
      ),
    );
  }
}

class _ProjectInformation extends ConsumerWidget {
  const _ProjectInformation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectSelectedProvider);
    return Row(
      children: [
        const Icon(
          LucideIcons.info,
          size: 16,
        ),
        const Gap(8),
        Text(
          project.name,
          style: ShadTheme.of(context).textTheme.p,
        ),
        if (project.type == ProjectType.json) ...[
          const Gap(8),
          ShadTooltip(
            builder: (context) => Text((project as ProjectJson).path),
            child: const ShadBadge(
              child: Text('JSON'),
            ),
          ),
        ]
      ],
    );
  }
}

class _OpenCLI extends ConsumerWidget {
  const _OpenCLI();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectSelectedProvider);
    final actionState = ref.watch(headbarActionsControllerProvider);

    ref.listen(headbarActionsControllerProvider, (prev, next) {
      if (!next.isLoading && next.hasError) {
        toastification.show(
          context: context,
          autoCloseDuration: const Duration(seconds: 5),
          type: ToastificationType.error,
          title: const Text('Open Terminal Failed'),
          description: Text(
            next.error.toString(),
          ),
        );
      }
    });
    return ShadButton.outline(
      size: ShadButtonSize.sm,
      enabled: !actionState.isLoading,
      icon: const Icon(LucideIcons.terminal, size: 14),
      child: const Row(
        children: [
          Gap(8),
          Text(
            'Open Terminal',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
      onPressed: () {
        ref
            .read(headbarActionsControllerProvider.notifier)
            .openTerminal(project);
      },
    );
  }
}

class _OpenDirectory extends ConsumerWidget {
  const _OpenDirectory();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectSelectedProvider);
    final actionState = ref.watch(headbarActionsControllerProvider);

    ref.listen(headbarActionsControllerProvider, (prev, next) {
      if (!next.isLoading && next.hasError) {
        toastification.show(
          context: context,
          autoCloseDuration: const Duration(seconds: 5),
          type: ToastificationType.error,
          title: const Text('Open Directory Failed'),
          description: Text(
            next.error.toString(),
          ),
        );
      }
    });
    return ShadButton.outline(
      enabled: !actionState.isLoading,
      size: ShadButtonSize.sm,
      icon: const ShadImage.square(LucideIcons.folder, size: 14),
      child: const Row(
        children: [
          Gap(8),
          Text(
            'Reveal in Directory',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
      onPressed: () {
        ref
            .read(headbarActionsControllerProvider.notifier)
            .openDirectory(project);
      },
    );
  }
}

class _SwitchProject extends ConsumerWidget {
  const _SwitchProject();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ShadButton.ghost(
      size: ShadButtonSize.sm,
      onPressed: () {
        context.router.replace(const ProjectsRoute());
      },
      icon: const ShadImage.square(LucideIcons.arrowLeftRight, size: 14),
      child: const Row(
        children: [
          Gap(8),
          Text(
            'Switch Project',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
