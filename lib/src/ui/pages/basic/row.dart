// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';

part 'row.g.dart';

final rowItem = CodeItem(
  title: (context) => context.tr.row,
  code: const TheCode(),
  widget: const TheWidget(),
);

class RowConfig {
  RowConfig({
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
  });

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;

  RowConfig copyWith({
    MainAxisAlignment? mainAxisAlignment,
    MainAxisSize? mainAxisSize,
    CrossAxisAlignment? crossAxisAlignment,
    VerticalDirection? verticalDirection,
  }) {
    return RowConfig(
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      mainAxisSize: mainAxisSize ?? this.mainAxisSize,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      verticalDirection: verticalDirection ?? this.verticalDirection,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  RowConfig build() => RowConfig();
  void change(RowConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'Row',
      apiUrl: '/flutter/widgets/Row-class.html',
      named: {
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
            Container(height: 32, width: 16, color: Colors.green),
            Container(height: 64, width: 32, color: Colors.teal),
            Container(height: 128, width: 48, color: Colors.amber),
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
        child: Row(
          mainAxisAlignment: config.mainAxisAlignment,
          mainAxisSize: config.mainAxisSize,
          crossAxisAlignment: config.crossAxisAlignment,
          verticalDirection: config.verticalDirection,
          children: [
            Container(height: 32, width: 16, color: Colors.green),
            Container(height: 64, width: 32, color: Colors.teal),
            Container(height: 128, width: 48, color: Colors.amber),
          ],
        ),
      ),
      configs: [
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
