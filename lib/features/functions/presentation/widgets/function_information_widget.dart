import 'package:appwrite_workbench/core/api_scopes.dart';
import 'package:appwrite_workbench/features/functions/presentation/controllers/function_detail_controller.dart';
import 'package:appwrite_workbench/models/function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:toastification/toastification.dart';

class FunctionInformationWidget extends ConsumerWidget {
  const FunctionInformationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        _Name(),
        Gap(16),
        _Configuration(),
        Gap(16),
        _ExecuteAccess(),
        Gap(16),
        _Events(),
        Gap(16),
        _Schedule(),
        Gap(16),
        _Timeout(),
        Gap(16),
        _Scopes(),
      ],
    );
  }
}

class _Name extends HookConsumerWidget {
  const _Name();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final function = ref.watch(FunctionDetailController.provider);

    final name = useTextEditingController(text: function.value?.name ?? '');

    ref.listen(FunctionDetailController.provider, (prev, next) {
      if (next is AsyncData) {
        if (next.value is FunctionApi) {
          final effectiveFunctionApi = next.value as FunctionApi;
          name.text = effectiveFunctionApi.name;
        }
      }
    });
    return ShadCard(
      width: double.infinity,
      title: Text(
        'Name',
        style: ShadTheme.of(context).textTheme.p,
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ShadButton(
            enabled: !function.isLoading,
            size: ShadButtonSize.sm,
            onPressed: () {
              if (function.value is FunctionApi) {
                final effectiveFunctionApi = function.value as FunctionApi;
                ref
                    .read(FunctionDetailController.provider.notifier)
                    .updateFunction(
                      function: effectiveFunctionApi.copyWith(
                        name: name.text,
                      ),
                      onSuccess: () => toastification.show(
                        title: const Text('Success'),
                        description: const Text('Function name updated'),
                        type: ToastificationType.success,
                      ),
                    );
              } else {
                toastification.show(
                  title: const Text('Not supported'),
                  description:
                      const Text('Function from json is not supported yet'),
                  type: ToastificationType.error,
                );
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(5),
          ShadInput(
            controller: name,
          ),
          const Gap(5),
        ],
      ),
    );
  }
}

class _Configuration extends HookConsumerWidget {
  const _Configuration();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final function = ref.watch(FunctionDetailController.provider);

    final entrypoint =
        useTextEditingController(text: function.value?.entrypoint ?? '');

    final commands =
        useTextEditingController(text: function.value?.commands ?? '');

    ref.listen(FunctionDetailController.provider, (prev, next) {
      if (next is AsyncData) {
        if (next.value is FunctionApi) {
          final effectiveFunctionApi = next.value as FunctionApi;
          entrypoint.text = effectiveFunctionApi.entrypoint ?? '';
          commands.text = effectiveFunctionApi.commands ?? '';
        }
      }
    });
    return ShadCard(
      width: double.infinity,
      title: Text(
        'Configuration',
        style: ShadTheme.of(context).textTheme.p,
      ),
      description:
          const Text('Set install and build commands for your function'),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ShadButton(
            enabled: !function.isLoading,
            size: ShadButtonSize.sm,
            onPressed: () {
              if (function.value is FunctionApi) {
                final effectiveFunctionApi = function.value as FunctionApi;
                ref
                    .read(FunctionDetailController.provider.notifier)
                    .updateFunction(
                      function: effectiveFunctionApi.copyWith(
                        entrypoint: entrypoint.text,
                        commands: commands.text,
                      ),
                      onSuccess: () => toastification.show(
                        title: const Text('Success'),
                        description:
                            const Text('Function configuration updated'),
                        type: ToastificationType.success,
                      ),
                    );
              } else {
                toastification.show(
                  title: const Text('Not supported'),
                  description:
                      const Text('Function from json is not supported yet'),
                  type: ToastificationType.error,
                );
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(16),
          ShadInputFormField(
            label: const Text('Entrypoint'),
            controller: entrypoint,
          ),
          const Gap(5),
          ShadInputFormField(
            label: const Text('Commands'),
            controller: commands,
          ),
          const Gap(5),
        ],
      ),
    );
  }
}

class _ExecuteAccess extends HookConsumerWidget {
  const _ExecuteAccess();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final function = ref.watch(FunctionDetailController.provider);
    final accesses = useState(List<String>.from(function.value?.execute ?? []));

    ref.listen(FunctionDetailController.provider, (prev, next) {
      if (next is AsyncData) {
        if (next.value is FunctionApi) {
          final effectiveFunctionApi = next.value as FunctionApi;
          accesses.value =
              List<String>.from(effectiveFunctionApi.execute ?? []);
        }
      }
    });

    return ShadCard(
      width: double.infinity,
      title: Text(
        'Execute Access',
        style: ShadTheme.of(context).textTheme.p,
      ),
      description: const Text(
          'Choose who can execute this function using the client API.'),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ShadButton(
            enabled: !function.isLoading,
            size: ShadButtonSize.sm,
            onPressed: () {
              if (function.value is FunctionApi) {
                final effectiveFunctionApi = function.value as FunctionApi;
                ref
                    .read(FunctionDetailController.provider.notifier)
                    .updateFunction(
                      function: effectiveFunctionApi.copyWith(
                        execute: accesses.value,
                      ),
                      onSuccess: () => toastification.show(
                        title: const Text('Success'),
                        description:
                            const Text('Function execute access updated'),
                        type: ToastificationType.success,
                      ),
                    );
              } else {
                toastification.show(
                  title: const Text('Not supported'),
                  description:
                      const Text('Function from json is not supported yet'),
                  type: ToastificationType.error,
                );
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(16),
          ...accesses.value.map(
            (access) => Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ShadTheme.of(context).colorScheme.border,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(access),
                  const Spacer(),
                  ShadButton.ghost(
                    size: ShadButtonSize.sm,
                    onPressed: () {
                      accesses.value = accesses.value
                          .where((element) => element != access)
                          .toList();
                    },
                    icon: const ShadImage.square(
                      LucideIcons.x,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(8),
          ShadButton.ghost(
            width: double.infinity,
            size: ShadButtonSize.sm,
            onPressed: () async {
              final newRole = await showShadDialog<String>(
                context: context,
                builder: (_) => const _AddRoleAccess(),
              );

              if (newRole != null) {
                accesses.value = [...accesses.value, newRole];
              }
            },
            icon: const ShadImage.square(
              LucideIcons.plus,
              size: 16,
            ),
            child: const Text('Add Role'),
          ),
          const Gap(8),
        ],
      ),
    );
  }
}

class _AddRoleAccess extends HookConsumerWidget {
  const _AddRoleAccess();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = useState('');
    return ShadDialog(
      title: const Text('Custom permission'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(16),
          ShadInputFormField(
            label: const Text('Role'),
            initialValue: role.value,
            onChanged: (value) => role.value = value,
            placeholder: const Text('user:[USER_ID] or team:[TEAM_ID]/[ROLE]'),
            description: const Row(
              children: [
                ShadImage.square(
                  LucideIcons.info,
                  size: 18,
                ),
                Gap(8),
                Expanded(
                  child: Text(
                    'A permission should be formatted as: user:[USER_ID] or team:[TEAM_ID]/[ROLE]',
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          ShadButton(
            enabled: role.value.isNotEmpty,
            onPressed: () {
              if (role.value.isEmpty) {
                Navigator.of(context).pop();
                return;
              }
              Navigator.of(context).pop(role.value);
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}

class _Events extends HookConsumerWidget {
  const _Events();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final function = ref.watch(FunctionDetailController.provider);
    final events = useState(List<String>.from(function.value?.events ?? []));

    ref.listen(FunctionDetailController.provider, (prev, next) {
      if (next is AsyncData) {
        if (next.value is FunctionApi) {
          final effectiveFunctionApi = next.value as FunctionApi;
          events.value = List<String>.from(effectiveFunctionApi.events ?? []);
        }
      }
    });

    return ShadCard(
      width: double.infinity,
      title: Text(
        'Events',
        style: ShadTheme.of(context).textTheme.p,
      ),
      description: const Text(
          'Set the events that will trigger your function. Maximum 100 events allowed.'),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ShadButton(
            enabled: !function.isLoading,
            size: ShadButtonSize.sm,
            onPressed: () {
              if (function.value is FunctionApi) {
                final effectiveFunctionApi = function.value as FunctionApi;
                ref
                    .read(FunctionDetailController.provider.notifier)
                    .updateFunction(
                      function: effectiveFunctionApi.copyWith(
                        events: events.value,
                      ),
                      onSuccess: () => toastification.show(
                        title: const Text('Success'),
                        description:
                            const Text('Function execute access updated'),
                        type: ToastificationType.success,
                      ),
                    );
              } else {
                toastification.show(
                  title: const Text('Not supported'),
                  description:
                      const Text('Function from json is not supported yet'),
                  type: ToastificationType.error,
                );
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(16),
          ...events.value.map(
            (access) => Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ShadTheme.of(context).colorScheme.border,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(access),
                  const Spacer(),
                  ShadButton.ghost(
                    size: ShadButtonSize.sm,
                    onPressed: () {
                      events.value = events.value
                          .where((element) => element != access)
                          .toList();
                    },
                    icon: const ShadImage.square(
                      LucideIcons.x,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(8),
          ShadButton.ghost(
            width: double.infinity,
            size: ShadButtonSize.sm,
            onPressed: () async {
              final newRole = await showShadDialog<String>(
                context: context,
                builder: (_) => const _AddEvent(),
              );

              if (newRole != null) {
                events.value = [...events.value, newRole];
              }
            },
            icon: const ShadImage.square(
              LucideIcons.plus,
              size: 16,
            ),
            child: const Text('Add Event'),
          ),
          const Gap(8),
        ],
      ),
    );
  }
}

class _AddEvent extends HookConsumerWidget {
  const _AddEvent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = useState('');
    return ShadDialog(
      title: const Text('Custom Events'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(16),
          ShadInputFormField(
            label: const Text('Event'),
            initialValue: event.value,
            onChanged: (value) => event.value = value,
            placeholder: const Text('e.g buckets.*.files.*.create'),
            description: const Row(
              children: [
                ShadImage.square(
                  LucideIcons.info,
                  size: 18,
                ),
                Gap(8),
                Expanded(
                  child: Text(
                    'Select events in your Appwrite project that will trigger your function',
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          ShadButton(
            enabled: event.value.isNotEmpty,
            onPressed: () {
              if (event.value.isEmpty) {
                Navigator.of(context).pop();
                return;
              }
              Navigator.of(context).pop(event.value);
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}

class _Schedule extends HookConsumerWidget {
  const _Schedule();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final function = ref.watch(FunctionDetailController.provider);

    final value =
        useTextEditingController(text: function.value?.schedule ?? '');

    ref.listen(FunctionDetailController.provider, (prev, next) {
      if (next is AsyncData) {
        if (next.value is FunctionApi) {
          final effectiveFunctionApi = next.value as FunctionApi;
          value.text = effectiveFunctionApi.schedule ?? '';
        }
      }
    });
    return ShadCard(
      width: double.infinity,
      description: const Text(
          'Set a Cron schedule to trigger your function. Leave blank for no schedule'),
      title: Text(
        'Schedule',
        style: ShadTheme.of(context).textTheme.p,
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ShadButton(
            enabled: !function.isLoading,
            size: ShadButtonSize.sm,
            onPressed: () {
              if (function.value is FunctionApi) {
                final effectiveFunctionApi = function.value as FunctionApi;
                ref
                    .read(FunctionDetailController.provider.notifier)
                    .updateFunction(
                      function: effectiveFunctionApi.copyWith(
                        schedule: value.text,
                      ),
                      onSuccess: () => toastification.show(
                        title: const Text('Success'),
                        description: const Text('Function schedule updated'),
                        type: ToastificationType.success,
                      ),
                    );
              } else {
                toastification.show(
                  title: const Text('Not supported'),
                  description:
                      const Text('Function from json is not supported yet'),
                  type: ToastificationType.error,
                );
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(16),
          ShadInputFormField(
            controller: value,
            label: const Text('Schedule (Cron Syntax)'),
            placeholder: const Text('* * * * *'),
          ),
          const Gap(5),
        ],
      ),
    );
  }
}

class _Timeout extends HookConsumerWidget {
  const _Timeout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final function = ref.watch(FunctionDetailController.provider);

    final value = useTextEditingController(
        text: function.value?.timeout?.toString() ?? '');

    ref.listen(FunctionDetailController.provider, (prev, next) {
      if (next is AsyncData) {
        if (next.value is FunctionApi) {
          final effectiveFunctionApi = next.value as FunctionApi;
          value.text = effectiveFunctionApi.timeout?.toString() ?? '';
        }
      }
    });
    return ShadCard(
      width: double.infinity,
      description: const Text(
          'Limit the execution time of your function. Maximum value is 900 seconds (15 minutes)'),
      title: Text(
        'Timeout',
        style: ShadTheme.of(context).textTheme.p,
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ShadButton(
            enabled: !function.isLoading,
            size: ShadButtonSize.sm,
            onPressed: () {
              if (function.value is FunctionApi) {
                final effectiveFunctionApi = function.value as FunctionApi;
                ref
                    .read(FunctionDetailController.provider.notifier)
                    .updateFunction(
                      function: effectiveFunctionApi.copyWith(
                        timeout: int.tryParse(value.text),
                      ),
                      onSuccess: () => toastification.show(
                        title: const Text('Success'),
                        description: const Text('Function Timeout updated'),
                        type: ToastificationType.success,
                      ),
                    );
              } else {
                toastification.show(
                  title: const Text('Not supported'),
                  description:
                      const Text('Function from json is not supported yet'),
                  type: ToastificationType.error,
                );
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(16),
          ShadInputFormField(
            controller: value,
            label: const Text('Time (in seconds)'),
          ),
          const Gap(5),
        ],
      ),
    );
  }
}

class _Scopes extends HookConsumerWidget {
  const _Scopes();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final function = ref.watch(FunctionDetailController.provider);

    final values = useState(List<ScopeEnum>.from(
        function.value?.scopes?.map((e) => ScopeEnum.fromCode(e)) ?? []));

    ref.listen(FunctionDetailController.provider, (prev, next) {
      if (next is AsyncData) {
        if (next.value is FunctionApi) {
          final effectiveFunctionApi = next.value as FunctionApi;
          values.value = List<ScopeEnum>.from(
              effectiveFunctionApi.scopes?.map((e) => ScopeEnum.fromCode(e)) ??
                  []);
        }
      }
    });
    return ShadCard(
      width: double.infinity,
      description: const Text(
          'Select scopes to grant the dynamic key generated temporarily for your function. It is best practice to allow only necessary permissions.'),
      title: Text(
        'Scopes',
        style: ShadTheme.of(context).textTheme.p,
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ShadButton(
            enabled: !function.isLoading,
            size: ShadButtonSize.sm,
            onPressed: () {
              if (function.value is FunctionApi) {
                final effectiveFunctionApi = function.value as FunctionApi;
                ref
                    .read(FunctionDetailController.provider.notifier)
                    .updateFunction(
                      function: effectiveFunctionApi.copyWith(
                        scopes: values.value.toCodes(),
                      ),
                      onSuccess: () => toastification.show(
                        title: const Text('Success'),
                        description: const Text('Function Scopes updated'),
                        type: ToastificationType.success,
                      ),
                    );
              } else {
                toastification.show(
                  title: const Text('Not supported'),
                  description:
                      const Text('Function from json is not supported yet'),
                  type: ToastificationType.error,
                );
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(16),
          ShadAccordion(
            initialValue: ScopeCategory.auth,
            children: [
              ...ScopeCategory.values.map((value) {
                return ShadAccordionItem(
                  value: value,
                  title: RichText(
                    text: TextSpan(text: value.title, children: [
                      TextSpan(
                        text:
                            ' (${values.value.where((element) => element.category == value).length})',
                        style: ShadTheme.of(context).textTheme.muted,
                      ),
                    ]),
                  ),
                  child: Column(children: [
                    ...ScopeEnum.values
                        .where((element) => element.category == value)
                        .map((scope) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        width: double.infinity,
                        child: ShadCheckbox(
                          value: values.value.contains(scope),
                          onChanged: (checked) {
                            if (checked) {
                              values.value = [...values.value, scope];
                            } else {
                              values.value = values.value
                                  .where((element) => element != scope)
                                  .toList();
                            }
                          },
                          label: Text(scope.code),
                          sublabel: Text(scope.description),
                        ),
                      );
                    }),
                  ]),
                );
              }),
            ],
          ),
          const Gap(5),
        ],
      ),
    );
  }
}
