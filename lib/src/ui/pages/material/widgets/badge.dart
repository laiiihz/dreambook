// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_span.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';

part 'badge.g.dart';

final badgeItem = CodeItem(
  title: 'Badge',
  code: const TheCode(),
  widget: const TheWidget(),
);

class BadgeConfig {
  BadgeConfig({
    this.smallSize = 6,
    this.largeSize = 16,
    this.hasLabel = false,
    this.visible = true,
  });
  final double smallSize;
  final double largeSize;
  final bool hasLabel;
  final bool visible;

  BadgeConfig copyWith({
    double? smallSize,
    double? largeSize,
    bool? hasLabel,
    bool? visible,
  }) {
    return BadgeConfig(
      smallSize: smallSize ?? this.smallSize,
      largeSize: largeSize ?? this.largeSize,
      hasLabel: hasLabel ?? this.hasLabel,
      visible: visible ?? this.visible,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  BadgeConfig build() => BadgeConfig();
  void change(BadgeConfig config) {
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
      'Badge(',
      '  smallSize: ${config.smallSize.toStringAsFixed(0)},',
      '  margeSize: ${config.largeSize.toStringAsFixed(0)},',
      if (config.hasLabel) "  label: const Text('99+'),",
      if (!config.visible) '  isLabelVisible: false,',
      '  child: const SomeWidget(),',
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
      content: Badge(
        isLabelVisible: config.visible,
        smallSize: config.smallSize,
        largeSize: config.largeSize,
        label: config.hasLabel ? const Text('99+') : null,
        child: Material(
          color: Theme.of(context).colorScheme.primary,
          shape: const StadiumBorder(),
          child: const SizedBox(width: 88, height: 32),
        ),
      ),
      configs: [
        SlidableTile(
          title: 'smallSize',
          value: config.smallSize,
          min: 0,
          max: 32,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(smallSize: t));
          },
        ),
        SlidableTile(
          title: 'largeSize',
          value: config.largeSize,
          min: 0,
          max: 32,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(largeSize: t));
          },
        ),
        SwitchListTile(
          title: const Text('has Label'),
          value: config.hasLabel,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(hasLabel: t));
          },
        ),
        SwitchListTile(
          title: const Text('Visible'),
          value: config.visible,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(visible: t));
          },
        ),
      ],
    );
  }
}
