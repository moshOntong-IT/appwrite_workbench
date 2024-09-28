import 'package:appwrite_workbench/core/provider_scope_extension.dart';
import 'package:appwrite_workbench/features/functions/presentation/controllers/function_list_controller.dart';
import 'package:appwrite_workbench/features/functions/presentation/widgets/function_detail_widget.dart';
import 'package:appwrite_workbench/features/functions/presentation/widgets/functions_headbar_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class FunctionsScreen extends ConsumerWidget {
  const FunctionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _Main().scope(
      overrides: [
        functionListControllerProvider.overrideWith(FunctionListController.new),
      ],
    );
  }
}

class _Main extends ConsumerWidget {
  const _Main();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        FunctionsHeadbarWidget(),
        Gap(20),
        Expanded(child: _Items()),
      ],
    );
  }
}

class _Items extends ConsumerWidget {
  const _Items();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final functionsState = ref.watch(functionListControllerProvider);
    return SingleChildScrollView(
      child: Wrap(
        children: [
          ...functionsState.when(
            data: (functions) {
              return functions.map((function) {
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      showShadSheet(
                        context: context,
                        side: ShadSheetSide.right,
                        builder: (context) => FunctionDetailWidget(
                          function: function,
                        ),
                      );
                    },
                    child: ShadCard(
                      title: Text(function.name),
                      description: Text(function.$id),
                      footer: Text(function.runtime),
                      child: const Gap(50),
                    ),
                  ),
                );
              }).toList();
            },
            loading: () => [
              const CircularProgressIndicator(),
            ],
            error: (error, stackTrace) => [
              Text(error.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
