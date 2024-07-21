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
        ],
      ),
    );
  }
}
