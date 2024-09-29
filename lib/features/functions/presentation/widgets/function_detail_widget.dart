import 'package:appwrite_workbench/core/appwrite_client.dart';
import 'package:appwrite_workbench/features/functions/functions_provider.dart';
import 'package:appwrite_workbench/features/functions/presentation/controllers/function_detail_actions_controller.dart';
import 'package:appwrite_workbench/features/functions/presentation/controllers/function_detail_controller.dart';
import 'package:appwrite_workbench/features/functions/presentation/controllers/function_pull_controller.dart';
import 'package:appwrite_workbench/features/functions/presentation/controllers/function_push_controller.dart';
import 'package:appwrite_workbench/features/functions/presentation/widgets/function_environment_widget.dart';
import 'package:appwrite_workbench/features/functions/presentation/widgets/function_information_widget.dart';
import 'package:appwrite_workbench/global_providars.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:appwrite_workbench/models/project.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:toastification/toastification.dart';

class FunctionDetailWidget extends ConsumerWidget {
  const FunctionDetailWidget({
    required this.appwriteClient,
    required this.project,
    required this.function,
    super.key,
  });

  final AppwriteClient appwriteClient;
  final ProjectWorkbench project;
  final FunctionWorkbench function;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        appwriteClientProvider.overrideWithValue(appwriteClient),
        projectSelectedProvider.overrideWithValue(project),
        FunctionPullController.provider
            .overrideWith(FunctionPullController.new),
        FunctionPushController.provider
            .overrideWith(FunctionPushController.new),
        FunctionDetailActionsController.provider
            .overrideWith(FunctionDetailActionsController.new),
        functionSelectedProvider.overrideWith(
          (_) => function,
        ),
        FunctionDetailController.provider.overrideWith(
          FunctionDetailController.new,
        ),
      ],
      child: const _Main(),
    );
  }
}

class _Main extends ConsumerWidget {
  const _Main();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final function = ref.watch(FunctionDetailController.provider);
    final pushState = ref.watch(FunctionPushController.provider);

    ref.listen(FunctionDetailController.provider, (prev, next) {
      if (!next.isLoading && next.hasError) {
        toastification.show(
          title: const Text('Error fetching function'),
          description: Text(next.error.toString()),
          autoCloseDuration: 3.seconds,
          type: ToastificationType.error,
        );
      }
    });

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
          Text(
            function.when(
              data: (data) {
                return data.name;
              },
              error: (error, stackTrace) {
                return 'Error';
              },
              loading: () => 'Loading...',
            ),
          ),
        ],
      ),
      description: Text(
        function.maybeWhen(
          data: (data) {
            return data.$id;
          },
          orElse: () => '',
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ShadButton(
                    onPressed: () async {
                      if (function.valueOrNull == null) {
                        return;
                      }
                      final projectSelected = ref.read(projectSelectedProvider);
                      final response = await showShadDialog<bool>(
                          context: context,
                          builder: (_) => const _PullConfirmation());
                      if (response != null && context.mounted) {
                        // Show Dialog a Loading Dialog
                        showShadDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return const ShadDialog(
                                closeIcon: SizedBox.shrink(),
                                title: Text('Pulling Function'),
                                description: Text(
                                  'Please wait while we pull the function from the cloud.',
                                ),
                              );
                            });
                        ref
                            .read(FunctionPullController.provider.notifier)
                            .pullFunction(
                              function: function.value!,
                              project: projectSelected,
                              replace: response,
                              onSuccess: () {
                                Navigator.of(context).pop();
                                toastification.show(
                                  title: const Text('Function Pulled'),
                                  description: const Text(
                                      'The function was pulled successfully.'),
                                  autoCloseDuration: 3.seconds,
                                  type: ToastificationType.success,
                                );
                              },
                              onError: (message) {
                                Navigator.of(context).pop();
                                toastification.show(
                                  title: const Text('Pull Failed'),
                                  description: Text(message.toString()),
                                  autoCloseDuration: 3.seconds,
                                  type: ToastificationType.error,
                                );
                              },
                            );
                      }
                    },
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
                    onPressed: () async {
                      final projectSelected = ref.read(projectSelectedProvider);
                      final response = await showShadDialog<bool>(
                          context: context,
                          builder: (_) =>
                              const _PushNotificationConfirmation());
                      if (response == true && context.mounted) {
                        // Show Dialog a Loading Dialog
                        showShadDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return ShadDialog(
                                closeIcon: const SizedBox.shrink(),
                                title: const Text('Pushing Function'),
                                description: RichText(
                                  text: TextSpan(
                                    text:
                                        'Please wait while we push the function into the cloud.',
                                    style: DefaultTextStyle.of(context)
                                        .style, // Use the default text style
                                    children: const <TextSpan>[
                                      TextSpan(
                                        text:
                                            ' (This may take a while depending on the size of the function.)',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                        ref
                            .read(FunctionPushController.provider.notifier)
                            .pushFunction(
                              function: function.value!,
                              project: projectSelected,
                              onSuccess: () {
                                Navigator.of(context).pop();
                                toastification.show(
                                  title: const Text('Function Pushed'),
                                  description: const Text(
                                      'The function was pushed successfully.'),
                                  autoCloseDuration: 3.seconds,
                                  type: ToastificationType.success,
                                );
                              },
                              onError: (message) {
                                Navigator.of(context).pop();
                                toastification.show(
                                  title: const Text('Push Failed'),
                                  description: Text(message.toString()),
                                  autoCloseDuration: 3.seconds,
                                  type: ToastificationType.error,
                                );
                              },
                            );
                      }
                    },
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
            ShadButton.outline(
              onPressed: () {
                final projectSelected = ref.read(projectSelectedProvider);
                ref
                    .read(FunctionDetailActionsController.provider.notifier)
                    .openDirectory(
                  function.value!,
                  projectSelected,
                  onError: (message) {
                    toastification.show(
                      title: const Text('Open Directory Failed'),
                      description: Text(message.toString()),
                      autoCloseDuration: 3.seconds,
                      type: ToastificationType.error,
                    );
                  },
                );
              },
              icon: const ShadImage.square(
                LucideIcons.folder,
                size: 16,
              ),
              width: double.infinity,
              child: const Row(
                children: [
                  Gap(8),
                  Text('Reveal in Directory'),
                ],
              ),
            ),
            const Gap(8),
            ShadButton.outline(
              onPressed: () {
                final projectSelected = ref.read(projectSelectedProvider);
                ref
                    .read(FunctionDetailActionsController.provider.notifier)
                    .openVscode(
                  function.value!,
                  projectSelected,
                  onError: (message) {
                    toastification.show(
                      title: const Text('Open Vscode Failed'),
                      description: Text(message.toString()),
                      autoCloseDuration: 3.seconds,
                      type: ToastificationType.error,
                    );
                  },
                );
              },
              foregroundColor: Colors.blue,
              icon: const ShadImage(
                'assets/icons/vscode.png',
                height: 16,
                width: 16,
              ),
              width: double.infinity,
              child: const Row(
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

class _PullConfirmation extends ConsumerWidget {
  const _PullConfirmation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ShadDialog.alert(
      title: const Text('Pull Confirmation'),
      description: RichText(
        text: TextSpan(
          text:
              'Do you want to replace the existing code with the code from the cloud?',
          style:
              DefaultTextStyle.of(context).style, // Use the default text style
          children: const <TextSpan>[
            TextSpan(
              text:
                  ' (If you select no, the existing code will be preserved. But the metadata will be updated.)',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
      actions: [
        ShadButton.destructive(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ShadButton.outline(
          width: 100,
          child: const Text('No'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        ShadButton(
          width: 100,
          child: const Text('Yes'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}

class _PushNotificationConfirmation extends ConsumerWidget {
  const _PushNotificationConfirmation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ShadDialog.alert(
      title: const Text('Are you absolutely sure?'),
      description: const Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          'Do you really want to push this function into the cloud?',
        ),
      ),
      actions: [
        ShadButton.outline(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        ShadButton(
          child: const Text('Proceed'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}

class _Tabs extends ConsumerWidget {
  const _Tabs();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final functionState = ref.watch(FunctionDetailController.provider);
    return ShadTabs<String>(
      value: 'information',
      tabs: [
        ShadTab(
          value: 'information',
          content: functionState.maybeWhen(
            data: (data) {
              return const FunctionInformationWidget();
            },
            orElse: () => const SizedBox.shrink(),
          ),
          child: const Text('Detail'),
        ),
        ShadTab(
          value: 'env',
          content: functionState.maybeWhen(
            data: (data) {
              return const FunctionEnvironmentWidget();
            },
            orElse: () => const SizedBox.shrink(),
          ),
          child: const Text('Environment Variables'),
        ),
      ],
    );
  }
}
