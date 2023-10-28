// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'activity_indicator.g.dart';

final activityIndicatorItem = CodeItem(
  title: 'Activity Indicator',
  code: const TheCode(),
  widget: const TheWidget(),
);

class ActivityIndocatorConfig {
  ActivityIndocatorConfig({
    this.partiallyRevealed = false,
    this.animated = true,
    this.value = 1.0,
    this.radius = 10,
  });

  final bool partiallyRevealed;
  final bool animated;
  final double value;
  final double radius;

  ActivityIndocatorConfig copyWith({
    bool? partiallyRevealed,
    bool? animated,
    double? value,
    double? radius,
  }) {
    return ActivityIndocatorConfig(
      partiallyRevealed: partiallyRevealed ?? this.partiallyRevealed,
      animated: animated ?? this.animated,
      value: value ?? this.value,
      radius: radius ?? this.radius,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  ActivityIndocatorConfig build() => ActivityIndocatorConfig();
  void change(ActivityIndocatorConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      config.partiallyRevealed
          ? 'CupertinoActivityIndicator'
          : 'CupertinoActivityIndicator.partiallyRevealed',
      named: {
        if (config.radius != 10)
          'radius': refer(config.radius.toStringAsFixed(2)),
        if (config.partiallyRevealed) ...{
          'progress': refer(config.value.toStringAsFixed(2)),
        } else ...{
          'animating': refer(config.animated.toString()),
        }
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
      content: config.partiallyRevealed
          ? CupertinoActivityIndicator.partiallyRevealed(
              radius: config.radius,
              progress: config.value,
            )
          : CupertinoActivityIndicator(
              radius: config.radius,
              animating: config.animated,
            ),
      configs: [
        SwitchListTile(
          title: const Text('partiallyRevealed'),
          value: config.partiallyRevealed,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(partiallyRevealed: t));
          },
        ),
        SlidableTile(
          title: 'radius',
          value: config.radius,
          min: 4,
          max: 48,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(radius: t));
          },
        ),
        if (config.partiallyRevealed)
          SlidableTile(
            title: 'value',
            value: config.value,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(value: t));
            },
          )
        else
          SwitchListTile(
            title: const Text('animated'),
            value: config.animated,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(animated: t));
            },
          ),
      ],
    );
  }
}