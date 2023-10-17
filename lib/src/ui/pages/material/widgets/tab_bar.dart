// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_span.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'tab_bar.g.dart';

final tabBarItem = CodeItem(
  title: 'Tab Bar',
  code: const TheCode(),
  widget: const TheWidget(),
);

class TabBarConfig {
  final bool isScrollable;
  final TabAlignment tabAlignment;

  TabBarConfig({
    this.isScrollable = false,
    this.tabAlignment = TabAlignment.fill,
  });

  TabBarConfig copyWith({
    bool? isScrollable,
    TabAlignment? tabAlignment,
  }) {
    return TabBarConfig(
      isScrollable: isScrollable ?? this.isScrollable,
      tabAlignment: tabAlignment ?? this.tabAlignment,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  TabBarConfig build() => TabBarConfig();
  void change(TabBarConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return CodeSpace([
      StaticCodes.material,
      '',
      'DefaultTabController(',
      '  length: 2,',
      '  child: TabBar(',
      if (config.isScrollable) '    isScrollable: true,',
      if (config.tabAlignment != TabAlignment.fill)
        '    tabAlignment: ${config.tabAlignment.name},',
      "    tabs: const [Tab(text: 'FOO'), Tab(text: 'BAR')],",
      '  ),',
      ')',
    ]);
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: DefaultTabController(
        length: 2,
        child: TabBar(
          isScrollable: config.isScrollable,
          tabAlignment: config.tabAlignment,
          tabs: const [Tab(text: 'FOO'), Tab(text: 'BAR')],
        ),
      ),
      configs: [
        SwitchListTile(
          title: const Text('Scrollable'),
          value: config.isScrollable,
          onChanged: (t) {
            if (t) {
              ref.read(configProvider.notifier).change(config.copyWith(
                  tabAlignment: TabAlignment.startOffset, isScrollable: true));
            } else {
              ref.read(configProvider.notifier).change(config.copyWith(
                  tabAlignment: TabAlignment.fill, isScrollable: false));
            }
          },
        ),
        MenuTile(
          title: 'Tab Alignment',
          items: [
            TabAlignment.center,
            if (config.isScrollable) ...[
              TabAlignment.start,
              TabAlignment.startOffset,
            ] else ...[
              TabAlignment.fill
            ],
          ],
          current: config.tabAlignment,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(tabAlignment: t));
          },
          contentBuilder: (t) => t.name,
        ),
      ],
    );
  }
}
