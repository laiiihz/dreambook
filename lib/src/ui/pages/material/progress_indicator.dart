// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:dreambook/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'progress_indicator.g.dart';

final progressIndicatorItem = CodeItem(
  title: (context) => context.tr.progressIndicator,
  code: const TheCode(),
  widget: const TheWidget(),
);

enum IndicatorType {
  circular('CircularProgressIndicator'),
  linear('LinearProgressIndicator'),
  ;

  const IndicatorType(this.code);
  final String code;
}

class IndicatorConfig {
  IndicatorConfig({
    this.type = IndicatorType.circular,
    this.value = 0,
    this.loading = true,
    this.minHeight = 4,
    this.borderRadius = 2,
    this.strokeWidth = 4.0,
    this.strokeCap = StrokeCap.round,
  });
  final IndicatorType type;
  final double value;
  final bool loading;
  final double minHeight;
  final double borderRadius;
  final double strokeWidth;
  final StrokeCap strokeCap;

  IndicatorConfig copyWith({
    IndicatorType? type,
    double? value,
    bool? loading,
    double? minHeight,
    double? borderRadius,
    double? strokeWidth,
    StrokeCap? strokeCap,
  }) {
    return IndicatorConfig(
      type: type ?? this.type,
      value: value ?? this.value,
      loading: loading ?? this.loading,
      minHeight: minHeight ?? this.minHeight,
      borderRadius: borderRadius ?? this.borderRadius,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      strokeCap: strokeCap ?? this.strokeCap,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  IndicatorConfig build() => IndicatorConfig();

  void change(IndicatorConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);

    final strokeWidth = config.strokeWidth.readableStr();
    final minHeight = config.minHeight.readableStr();
    final borderRadius = config.borderRadius.readableStr();
    final progress = config.value.readableStr();
    return AutoCode(
      config.type.code,
      apiUrl: switch (config.type) {
        IndicatorType.circular =>
          '/flutter/material/CircularProgressIndicator-class.html',
        IndicatorType.linear =>
          '/flutter/material/LinearProgressIndicator-class.html',
      },
      named: {
        if (!config.loading) 'value': refer(progress),
        ...switch (config.type) {
          IndicatorType.circular => {
              if (strokeWidth != '4') 'strokeWidth': refer(strokeWidth),
              'strokeCap': refer('StrokeCap.${config.strokeCap.name}'),
            },
          IndicatorType.linear => {
              if (minHeight != '4') 'minHeight': refer(minHeight),
              if (borderRadius != '0') 'borderRadius': refer(borderRadius),
            },
        },
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final isLinear = config.type == IndicatorType.linear;
    final isCircular = config.type == IndicatorType.circular;
    return WidgetWithConfiguration(
      content: switch (config.type) {
        IndicatorType.circular => CircularProgressIndicator(
            value: config.loading ? null : config.value,
            strokeCap: config.strokeCap,
            strokeWidth: config.strokeWidth,
          ),
        IndicatorType.linear => LinearProgressIndicator(
            value: config.loading ? null : config.value,
            minHeight: config.minHeight,
            borderRadius: BorderRadius.circular(config.borderRadius),
          ),
        // pattern =>
      },
      configs: [
        MenuTile<IndicatorType>(
          title: context.tr.theType,
          items: IndicatorType.values,
          current: config.type,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(type: t));
          },
          contentBuilder: (t) => t.name,
        ),
        SwitchListTile(
          title: Text(context.tr.loading),
          value: config.loading,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(loading: t));
          },
        ),
        if (!config.loading)
          SlidableTile(
            title: context.tr.value,
            value: config.value,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(value: t));
            },
          ),
        if (isLinear)
          SlidableTile(
            title: context.tr.minHeight,
            value: config.minHeight,
            min: 1,
            max: 24,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(minHeight: t));
            },
          ),
        if (isLinear)
          SlidableTile(
            title: context.tr.borderRadius,
            value: config.borderRadius,
            min: 0,
            max: 24,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(borderRadius: t));
            },
          ),
        if (isCircular)
          SlidableTile(
            title: context.tr.strokeWidth,
            value: config.strokeWidth,
            min: 0,
            max: 12,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(strokeWidth: t));
            },
          ),
        if (isCircular)
          MenuTile(
            title: context.tr.strokeCap,
            items: StrokeCap.values,
            current: config.strokeCap,
            onTap: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(strokeCap: t));
            },
            contentBuilder: (t) => t.name,
          ),
      ],
    );
  }
}
