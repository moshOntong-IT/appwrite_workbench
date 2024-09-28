import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final _indexProvider = StateProvider<int>((ref) => 0);
final _onIndexChangeProvider = Provider<void Function(int)>((ref) {
  throw UnimplementedError();
});

enum DrawerItemEnum {
  functions(icon: LucideIcons.zap, title: 'Functions'),
  // databases(icon: LucideIcons.database, title: 'Databases'),
  // backup(icon: LucideIcons.databaseBackup, title: 'Backup & Restore'),
  ;

  const DrawerItemEnum({required this.icon, required this.title});

  final IconData icon;
  final String title;
}

class ProjectDrawer extends ConsumerWidget {
  const ProjectDrawer({
    required this.currentIndex,
    required this.onIndexChange,
    super.key,
  });

  final int currentIndex;
  final Function(int) onIndexChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        _onIndexChangeProvider.overrideWithValue(onIndexChange),
      ],
      child: MaxWidthBox(
        maxWidth: 250,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: ShadTheme.of(context).colorScheme.muted,
              ),
            ),
          ),
          child: const Column(
            children: [
              Expanded(
                child: _Items(),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Items extends ConsumerWidget {
  const _Items();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: DrawerItemEnum.values.length,
      itemBuilder: (context, index) {
        final item = DrawerItemEnum.values[index];
        return _Item(
          item: item,
          index: index,
        );
      },
    );
  }
}

class _Item extends ConsumerWidget {
  const _Item({
    required this.index,
    required this.item,
  });

  final DrawerItemEnum item;
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(_indexProvider);

    return ListTile(
      leading: ShadImage.square(size: 18, item.icon),
      title: Text(item.title),
      onTap: () {
        ref.read(_onIndexChangeProvider)(index);
        ref.read(_indexProvider.notifier).state = index;
      },
      selected: currentIndex == index,
    );
  }
}
