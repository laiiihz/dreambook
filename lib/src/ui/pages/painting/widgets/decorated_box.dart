import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'decorated_box.g.dart';

final decoratedBoxItem = CodeItem(
  title: 'Decorated Box',
  code: const TheCode(),
  widget: const TheWidget(),
);

enum GradientType {
  none(''),
  linear('LinearGradient'),
  radial('RadialGradient'),
  sweep('SweepGradient'),
  ;

  const GradientType(this.code);
  final String code;
}

class DecoratedBoxConfig {
  DecoratedBoxConfig({
    this.position = DecorationPosition.background,
    this.shape = BoxShape.rectangle,
    this.hasBorderRadius = false,
    this.hasColor = true,
    this.hasBoxShadow = false,
    this.gradientType = GradientType.none,
  });

  final DecorationPosition position;
  final BoxShape shape;
  final bool hasBorderRadius;
  final bool hasColor;
  final bool hasBoxShadow;
  final GradientType gradientType;

  DecoratedBoxConfig copyWith({
    DecorationPosition? position,
    BoxShape? shape,
    bool? hasBorderRadius,
    bool? hasColor,
    bool? hasBoxShadow,
    GradientType? gradientType,
  }) {
    return DecoratedBoxConfig(
      position: position ?? this.position,
      shape: shape ?? this.shape,
      hasBorderRadius: hasBorderRadius ?? this.hasBorderRadius,
      hasColor: hasColor ?? this.hasColor,
      hasBoxShadow: hasBoxShadow ?? this.hasBoxShadow,
      gradientType: gradientType ?? this.gradientType,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  DecoratedBoxConfig build() => DecoratedBoxConfig();
  void change(DecoratedBoxConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'DecoratedBox',
      named: {
        'decoration': InvokeExpression.newOf(
          refer('BoxDecoration'),
          [],
          {
            if (config.hasColor)
              'color': refer('Colors.green.withOpacity(0.5)'),
            if (config.shape != BoxShape.rectangle)
              'shape': refer('BoxShape.${config.shape.name}')
            else if (config.hasBorderRadius)
              'borderRadius': InvokeExpression.newOf(
                  refer('BorderRadius'), [refer('12')], {}, [], 'circular'),
            if (config.hasBoxShadow)
              'boxShadow': literalConstList(
                  [refer('BoxShadow(color: Colors.blue, blurRadius: 12)')]),
            if (config.position != DecorationPosition.background)
              'position': refer('DecorationPosition.${config.position.name}'),
            if (config.gradientType != GradientType.none)
              'gradient': switch (config.gradientType) {
                GradientType.linear ||
                GradientType.radial ||
                GradientType.sweep =>
                  refer(
                      '${config.gradientType.code}(colors: [Colors.red, Colors.green])'),
                _ => refer('null'),
              }
          },
        ),
        'child': refer(
          'const SizedBox.square(dimension: 120, child: FlutterLogo(),)',
        ),
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final colors = [Colors.red, Colors.green];
    return WidgetWithConfiguration(
      content: DecoratedBox(
        decoration: BoxDecoration(
          color: config.hasColor ? Colors.green.withOpacity(0.5) : null,
          shape: config.shape,
          borderRadius:
              (config.hasBorderRadius && config.shape == BoxShape.rectangle)
                  ? BorderRadius.circular(16)
                  : null,
          // image: DecorationImage(image: image),
          boxShadow: config.hasBoxShadow
              ? const [BoxShadow(color: Colors.blue, blurRadius: 12)]
              : null,
          gradient: switch (config.gradientType) {
            GradientType.none => null,
            GradientType.linear => LinearGradient(colors: colors),
            GradientType.radial => RadialGradient(colors: colors),
            GradientType.sweep => SweepGradient(colors: colors),
          },
        ),
        position: config.position,
        child: const SizedBox.square(dimension: 120, child: FlutterLogo()),
      ),
      configs: [
        MenuTile(
          title: 'Position',
          items: DecorationPosition.values,
          current: config.position,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(position: t));
          },
          contentBuilder: (t) => t.name,
        ),
        MenuTile(
          title: 'Shape',
          items: BoxShape.values,
          current: config.shape,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(shape: t));
          },
          contentBuilder: (t) => t.name,
        ),
        if (config.shape == BoxShape.rectangle)
          SwitchListTile(
            title: const Text('Has Border Radius'),
            value: config.hasBorderRadius,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(hasBorderRadius: t));
            },
          ),
        SwitchListTile(
          title: const Text('Has Color'),
          value: config.hasColor,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(hasColor: t));
          },
        ),
        SwitchListTile(
          title: const Text('Has Box Shadow'),
          value: config.hasBoxShadow,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(hasBoxShadow: t));
          },
        ),
        MenuTile(
          title: 'Gradient Type',
          items: GradientType.values,
          current: config.gradientType,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(gradientType: t));
          },
          contentBuilder: (t) => t.name,
        ),
      ],
    );
  }
}
