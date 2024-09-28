import 'package:appwrite_workbench/models/project.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:toastification/toastification.dart';

class CreateProjectWidget extends HookConsumerWidget {
  const CreateProjectWidget(
      {required this.onApiCreate, required this.onJsonCreate, super.key});

  final void Function(
    ProjectApi project,
  ) onApiCreate;
  final void Function(ProjectJson json) onJsonCreate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final projectController = useTextEditingController();
    final endpointController = useTextEditingController();
    final apiKeyController = useTextEditingController();
    return MaxWidthBox(
      maxWidth: 450,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Link your ',
              children: [
                TextSpan(
                  text: 'Appwrite Project',
                  style: ShadTheme.of(context).textTheme.h2.copyWith(
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFF02D65),
                      ),
                ),
                const TextSpan(text: ' to get started'),
              ],
              style: ShadTheme.of(context).textTheme.h2,
            ),
          ),
          const Gap(16),
          ShadInput(
            controller: nameController,
            placeholder: const Text('Name'),
          ),
          const Gap(8),
          ShadInput(
            controller: projectController,
            placeholder: const Text('Project Id'),
          ),
          const Gap(8),
          ShadInput(
            controller: endpointController,
            placeholder: const Text('Endpoint'),
          ),
          const Gap(8),
          ShadInput(
            controller: apiKeyController,
            placeholder: const Text(
              'Api Key',
            ),
          ),
          const Gap(8),
          const ShadAlert(
            iconSrc: LucideIcons.terminal,
            title: Text('API Key must have access to all features.'),
            description: Text("Don't worry, your key will be stored securely."),
          ),
          const Gap(16),
          ShadButton(
            width: double.infinity,
            child: const Text('Link'),
            onPressed: () {
              if (projectController.text.isEmpty &&
                  endpointController.text.isEmpty &&
                  apiKeyController.text.isEmpty &&
                  nameController.text.isEmpty) {
                toastification.show(
                  title: const Text('Fields cannot be empty'),
                  description: const Text('Please fill in all fields'),
                  type: ToastificationType.error,
                );

                return;
              }
              final project = ProjectApi()
                ..projectId = projectController.text
                ..endpoint = endpointController.text
                ..name = nameController.text
                ..apiKey = apiKeyController.text;
              onApiCreate.call(
                project,
              );
            },
          ),
          const Gap(16),
          const Row(
            children: [
              Expanded(
                child: Divider(),
              ),
              Gap(8),
              Text('OR'),
              Gap(8),
              Expanded(
                child: Divider(),
              ),
            ],
          ),
          const Gap(16),
          ShadButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['json'],
              );

              if (result != null) {
                PlatformFile file = result.files.first;

                if (file.name == 'appwrite.json') {
                  final project = ProjectJson()..path = file.path!;
                  onJsonCreate.call(project);
                } else {
                  toastification.show(
                    title: const Text('Invalid file'),
                    description: const Text(
                      'Please select a valid Appwrite JSON file, the file must be named appwrite.json',
                    ),
                    type: ToastificationType.error,
                  );
                }
              }
            },
            width: double.infinity,
            icon: const Icon(
              LucideIcons.fileJson,
              size: 16,
            ),
            child: const Row(
              children: [
                Gap(8),
                Text(
                  'Appwrite Json',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
