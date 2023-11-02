// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';

part 'flex.g.dart';

final flexItem = CodeItem(
  title: (context) => context.tr.flex,
  code: const TheCode(),
  widget: const TheWidget(),
);

class FlexConfig {
  FlexConfig({
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    this.direction = Axis.horizontal,
  });

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
  final Axis direction;

  FlexConfig copyWith({
    MainAxisAlignment? mainAxisAlignment,
    MainAxisSize? mainAxisSize,
    CrossAxisAlignment? crossAxisAlignment,
    VerticalDirection? verticalDirection,
    Axis? direction,
  }) {
    return FlexConfig(
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      mainAxisSize: mainAxisSize ?? this.mainAxisSize,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      verticalDirection: verticalDirection ?? this.verticalDirection,
      direction: direction ?? this.direction,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  FlexConfig build() => FlexConfig();
  void change(FlexConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'Flex',
      apiUrl: '/flutter/widgets/Flex-class.html',
      named: {
        'direction': refer('Axis.${config.direction.name}'),
        if (config.mainAxisAlignment != MainAxisAlignment.start)
          'mainAxisAlignment':
              refer('MainAxisAlignment.${config.mainAxisAlignment.name}'),
        if (config.mainAxisSize != MainAxisSize.max)
          'mainAxisSize': refer('MainAxisSize.${config.mainAxisSize.name}'),
        if (config.crossAxisAlignment != CrossAxisAlignment.center)
          'crossAxisAlignment':
              refer('CrossAxisAlignment.${config.crossAxisAlignment.name}'),
        if (config.verticalDirection != VerticalDirection.down)
          'verticalDirection':
              refer('VerticalDirection.${config.verticalDirection.name}'),
        'children': refer('''[
            Container(width: 16, height: 16, color: Colors.green),
            Container(width: 32, height: 32, color: Colors.teal),
            Container(width: 64, height: 64, color: Colors.amber),
          ]'''),
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      initialFractions: const [0.4, 0.6],
      content: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
        ),
        child: Flex(
          mainAxisAlignment: config.mainAxisAlignment,
          mainAxisSize: config.mainAxisSize,
          crossAxisAlignment: config.crossAxisAlignment,
          verticalDirection: config.verticalDirection,
          direction: config.direction,
          children: [
            Container(width: 16, height: 16, color: Colors.green),
            Container(width: 32, height: 32, color: Colors.teal),
            Container(width: 64, height: 64, color: Colors.amber),
          ],
        ),
      ),
      configs: [
        MenuTile(
          title: 'Direction',
          items: Axis.values,
          current: config.direction,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(direction: t));
          },
          contentBuilder: (t) => t.name,
        ),
        MenuTile(
          title: 'Main Axis Alignment',
          items: MainAxisAlignment.values,
          current: config.mainAxisAlignment,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(mainAxisAlignment: t));
          },
          contentBuilder: (t) => t.name,
        ),
        MenuTile(
          title: 'Main Axis Size',
          items: MainAxisSize.values,
          current: config.mainAxisSize,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(mainAxisSize: t));
          },
          contentBuilder: (t) => t.name,
        ),
        MenuTile(
          title: 'Cross Axis Alignment',
          items: CrossAxisAlignment.values,
          current: config.crossAxisAlignment,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(crossAxisAlignment: t));
          },
          contentBuilder: (t) => t.name,
        ),
        MenuTile(
          title: 'Vertical Direction',
          items: VerticalDirection.values,
          current: config.verticalDirection,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(verticalDirection: t));
          },
          contentBuilder: (t) => t.name,
        ),
      ],
    );
  }
}
