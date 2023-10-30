// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'divider.g.dart';

final dividerItem = CodeItem(
  title: (context) => context.tr.divider,
  code: const TheCode(),
  widget: const TheWidget(),
);

class DividerConfig {
  DividerConfig({
    this.axis = Axis.horizontal,
    this.size = 8,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
  });
  final Axis axis;
  final double size;
  final double thickness;
  final double indent;
  final double endIndent;

  DividerConfig copyWith({
    Axis? axis,
    double? size,
    double? thickness,
    double? indent,
    double? endIndent,
  }) {
    return DividerConfig(
      axis: axis ?? this.axis,
      size: size ?? this.size,
      thickness: thickness ?? this.thickness,
      indent: indent ?? this.indent,
      endIndent: endIndent ?? this.endIndent,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  DividerConfig build() => DividerConfig();
  void change(DividerConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final sizeStr = config.size.toStringAsFixed(0);
    return AutoCode(
      switch (config.axis) {
        Axis.horizontal => 'Divider',
        Axis.vertical => 'VerticalDivider',
      },
      named: {
        if (sizeStr != '8')
          ...switch (config.axis) {
            Axis.horizontal => {'height': refer(sizeStr)},
            Axis.vertical => {'width': refer(sizeStr)},
          },
        if (config.thickness > 1)
          'thickness': refer(config.thickness.toStringAsFixed(1)),
        if (config.indent != 0)
          'indent': refer(config.indent.toStringAsFixed(1)),
        if (config.endIndent != 0)
          'endIndent': refer(config.endIndent.toStringAsFixed(1)),
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final box = Material(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: const SizedBox.square(dimension: 64),
    );
    final color = Theme.of(context).colorScheme.onBackground;
    return WidgetWithConfiguration(
      initialFractions: const [0.5, 0.5],
      content: switch (config.axis) {
        Axis.horizontal => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              box,
              Divider(
                height: config.size,
                indent: config.indent,
                endIndent: config.endIndent,
                thickness: config.thickness,
                color: color,
              ),
              box,
            ],
          ),
        Axis.vertical => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              box,
              VerticalDivider(
                width: config.size,
                indent: config.indent,
                endIndent: config.endIndent,
                thickness: config.thickness,
                color: color,
              ),
              box,
            ],
          ),
      },
      configs: [
        MenuTile<Axis>(
          title: 'Axis',
          items: Axis.values,
          current: config.axis,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(axis: t));
          },
          contentBuilder: (t) => t.name,
        ),
        SlidableTile(
          title: 'Size',
          value: config.size,
          min: 0,
          max: 32,
          onChanged: (state) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(size: state));
          },
        ),
        SlidableTile(
          title: 'Thickness',
          value: config.thickness,
          min: 0,
          max: 32,
          onChanged: (state) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(thickness: state));
          },
        ),
        SlidableTile(
          title: 'Indent',
          value: config.indent,
          min: 0,
          max: 32,
          onChanged: (state) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(indent: state));
          },
        ),
        SlidableTile(
          title: 'End Indent',
          value: config.endIndent,
          min: 0,
          max: 32,
          onChanged: (state) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(endIndent: state));
          },
        ),
      ],
    );
  }
}
