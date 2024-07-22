import 'package:appwrite_workbench/models/function.dart';
import 'package:flutter/material.dart';
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
      ),
      title: Text(function.name),
      description: Text(function.$id),
    );
  }
}
