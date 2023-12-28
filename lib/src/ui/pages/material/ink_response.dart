// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:dreambook/src/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';

part 'ink_response.g.dart';

final inkResponseItem = CodeItem(
  title: (context) => 'Ink Response',
  code: const TheCode(),
  widget: const TheWidget(),
);

class InkResponseConfig {
  InkResponseConfig({
    this.highlightShape = BoxShape.circle,
    this.radius = 32,
    this.borderRadius = 32,
    this.setRadius = false,
    this.setBorderRadius = false,
    this.splashFactory = InkRipple.splashFactory,
  });

  final BoxShape highlightShape;
  final double radius;
  final double borderRadius;
  final bool setRadius;
  final bool setBorderRadius;
  final InteractiveInkFeatureFactory splashFactory;

  InkResponseConfig copyWith({
    BoxShape? highlightShape,
    double? radius,
    double? borderRadius,
    bool? setRadius,
    bool? setBorderRadius,
    InteractiveInkFeatureFactory? splashFactory,
  }) {
    return InkResponseConfig(
      highlightShape: highlightShape ?? this.highlightShape,
      radius: radius ?? this.radius,
      borderRadius: borderRadius ?? this.borderRadius,
      setRadius: setRadius ?? this.setRadius,
      setBorderRadius: setBorderRadius ?? this.setBorderRadius,
      splashFactory: splashFactory ?? this.splashFactory,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  InkResponseConfig build() => InkResponseConfig();
  void change(InkResponseConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);

    final radius = config.radius.readableStr(0);
    final borderRadius = config.borderRadius.readableStr(0);
    return AutoCode(
      'InkResponse',
      named: {
        'onTap': Method((m) => m..body = Block()).closure,
        if (config.highlightShape != BoxShape.circle)
          'highlightShape': refer('BoxShape.${config.highlightShape.name}'),
        if (config.setRadius) 'radius': refer(radius),
        if (config.setBorderRadius)
          'borderRadius': refer('BorderRadius.circular($borderRadius)'),
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
      initialFractions: const [0.5, 0.5],
      content: Material(
        child: Center(
          child: InkResponse(
            onTap: () {},
            highlightShape: config.highlightShape,
            radius: config.setRadius ? config.radius : null,
            borderRadius: config.setBorderRadius
                ? BorderRadius.circular(config.borderRadius)
                : null,
            splashFactory: config.splashFactory,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Text('TAP HERE'),
            ),
          ),
        ),
      ),
      configs: [
        MenuTile(
          title: 'highlight shape',
          items: BoxShape.values,
          current: config.highlightShape,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(highlightShape: t));
          },
          contentBuilder: (t) => t.name,
        ),
        MenuTile(
          title: 'splash factory',
          items: const [
            if (!kIsWeb) InkSparkle.splashFactory,
            InkSplash.splashFactory,
            InkRipple.splashFactory,
          ],
          current: config.splashFactory,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(splashFactory: t));
          },
          contentBuilder: (t) {
            return switch (t) {
              InkSparkle.splashFactory => 'Ink Sparkle',
              InkSplash.splashFactory => 'Ink Splash',
              InkRipple.splashFactory => 'Ink Ripple',
              _ => '',
            };
          },
        ),
        SwitchListTile(
          title: const Text('set splash radius'),
          value: config.setRadius,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(setRadius: t));
          },
        ),
        if (config.setRadius)
          SlidableTile(
            title: 'splash radius value',
            value: config.radius,
            min: 8,
            max: 256,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(radius: t));
            },
          ),
        SwitchListTile(
          title: const Text('set border radius'),
          value: config.setBorderRadius,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(setBorderRadius: t));
          },
        ),
        if (config.setBorderRadius)
          SlidableTile(
            title: 'border radius value',
            value: config.borderRadius,
            min: 8,
            max: 256,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(borderRadius: t));
            },
          )
      ],
    );
  }
}
