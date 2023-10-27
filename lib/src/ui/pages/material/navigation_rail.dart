// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_builder_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_rail.g.dart';

final navigationRailItem = CodeItem(
  title: 'Navigation Rail',
  code: const TheCode(),
  widget: const TheWidget(),
);

class NavigationRailConfig {
  NavigationRailConfig({
    this.labelType = NavigationRailLabelType.none,
    this.extended = false,
    this.disabled = false,
    this.leading = false,
    this.trailing = false,
    this.hideIndicator = false,
  });

  final NavigationRailLabelType labelType;
  final bool extended;
  final bool disabled;
  final bool leading;
  final bool trailing;
  final bool hideIndicator;

  NavigationRailConfig copyWith({
    NavigationRailLabelType? labelType,
    bool? extended,
    bool? disabled,
    bool? leading,
    bool? trailing,
    bool? hideIndicator,
  }) {
    return NavigationRailConfig(
      labelType: labelType ?? this.labelType,
      extended: extended ?? this.extended,
      disabled: disabled ?? this.disabled,
      leading: leading ?? this.leading,
      trailing: trailing ?? this.trailing,
      hideIndicator: hideIndicator ?? this.hideIndicator,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  NavigationRailConfig build() => NavigationRailConfig();
  void change(NavigationRailConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  InvokeExpression genNaviItem({
    required bool disabled,
    required String icon,
    required String selectedIcon,
    required String label,
  }) {
    return InvokeExpression.newOf(
      refer('NavigationRailDestination'),
      [],
      {
        'icon': refer('const Icon(Icons.$icon)'),
        'selectedIcon': refer('const Icon(Icons.$selectedIcon)'),
        if (disabled) 'disabled': refer('true'),
        'label': refer('const Text(\'$label\')'),
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'NavigationRail',
      prefix: [
        Field((f) => f
          ..name = 'currentIndex'
          ..assignment = const Code('0')
          ..type = refer('int')),
      ],
      named: {
        if (config.labelType != NavigationRailLabelType.none)
          'labelType':
              refer('NavigationRailLabelType.${config.labelType.name}'),
        if (config.extended) 'extended': refer('true'),
        if (config.leading) 'leading': refer('const Icon(Icons.menu)'),
        if (config.trailing) 'trailing': refer('const Icon(Icons.settings)'),
        if (config.hideIndicator) 'useIndicator': refer('false'),
        'selectedIndex': refer('currentIndex'),
        'onDestinationSelected': Method((m) => m.body = Block((b) =>
                b.addExpression(CodeHelper.setState('currentIndex = value'))))
            .closure,
        'destinations': literalConstList([
          genNaviItem(
            disabled: config.disabled,
            icon: 'home',
            selectedIcon: 'home_outlined',
            label: 'Home',
          ),
          genNaviItem(
            disabled: config.disabled,
            icon: 'favorite',
            selectedIcon: 'favorite_outline',
            label: 'Favorite',
          ),
          genNaviItem(
            disabled: config.disabled,
            icon: 'person',
            selectedIcon: 'person_outlined',
            label: 'Profile',
          ),
        ]),
      },
    );
  }
}

@riverpod
class CurrentIndex extends _$CurrentIndex {
  @override
  int build() => 0;

  void change(int value) => state = value;
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      initialFractions: const [0.4, 0.6],
      axis: Axis.horizontal,
      content: ClipRect(
        child: OverflowBox(
          maxWidth: 148,
          minWidth: 48,
          alignment: Alignment.topLeft,
          child: NavigationRail(
            extended: config.extended,
            leading: config.leading ? const Icon(Icons.menu) : null,
            trailing: config.trailing ? const Icon(Icons.settings) : null,
            useIndicator: !config.hideIndicator,
            destinations: [
              NavigationRailDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home),
                label: const Text('Home'),
                disabled: config.disabled,
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.favorite_outline),
                selectedIcon: const Icon(Icons.favorite),
                label: const Text('Favorite'),
                disabled: config.disabled,
              )
            ],
            selectedIndex: ref.watch(currentIndexProvider),
            labelType: config.extended ? null : config.labelType,
            onDestinationSelected: (value) {
              ref.read(currentIndexProvider.notifier).change(value);
            },
          ),
        ),
      ),
      configs: [
        MenuTile(
          title: 'Label Type',
          items: NavigationRailLabelType.values,
          current: config.labelType,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(labelType: t));
          },
          contentBuilder: (t) => t.name,
        ),
        SwitchListTile(
          title: const Text('Extended'),
          value: config.extended,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(extended: t));
          },
        ),
        SwitchListTile(
          title: const Text('Disabled'),
          value: config.disabled,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(disabled: t));
          },
        ),
        SwitchListTile(
          title: const Text('Leading'),
          value: config.leading,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(leading: t));
          },
        ),
        SwitchListTile(
          title: const Text('Trailing'),
          value: config.trailing,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(trailing: t));
          },
        ),
        SwitchListTile(
          title: const Text('Hide Indicator'),
          value: config.hideIndicator,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(hideIndicator: t));
          },
        ),
      ],
    );
  }
}
