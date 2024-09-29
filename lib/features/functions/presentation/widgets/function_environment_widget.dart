import 'package:appwrite_workbench/features/functions/presentation/controllers/function_vars_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:toastification/toastification.dart';

class FunctionEnvironmentWidget extends ConsumerWidget {
  const FunctionEnvironmentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        FunctionVarsController.provider.overrideWith(
          FunctionVarsController.new,
        )
      ],
      child: const _Main(),
    );
  }
}

class _Main extends HookConsumerWidget {
  const _Main();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final varState = ref.watch(FunctionVarsController.provider);
    final vars = useTextEditingController(text: varState.value ?? '');

    ref.listen(FunctionVarsController.provider, (prev, next) {
      if (!next.isLoading && next.hasError) {
        toastification.show(
          title: const Text('Environment variables error'),
          description: Text(next.error.toString()),
          autoCloseDuration: 3.seconds,
          type: ToastificationType.error,
        );
      }
      if (next is AsyncData) {
        vars.text = next.value ?? '';
      }
    });
    return ShadCard(
      width: double.infinity,
      title: const Text(
        'Environment variables',
      ),
      description: const Text(
        'Set the environment variables or secret keys that will be passed to your function. The field accepts a list of key-value pairs separated by a newline. Similar to a .env file.',
      ),
      child: Column(
        children: [
          const Gap(16),
          ShadInput(
            placeholder: const Text('e.g key=value'),
            controller: vars,
            maxLines: 10,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 16,
            ),
          ),
          const Gap(8),
          ShadButton(
            onPressed: () {
              ref.read(FunctionVarsController.provider.notifier).saveVariables(
                    envString: vars.text,
                    onSuccess: () {
                      toastification.show(
                        title: const Text('Environment variables saved'),
                        autoCloseDuration: 3.seconds,
                        type: ToastificationType.success,
                      );
                    },
                  );
            },
            width: double.infinity,
            size: ShadButtonSize.sm,
            child: const Text(
              'Save Variable',
            ),
          ),
        ],
      ),
    );
  }
}
