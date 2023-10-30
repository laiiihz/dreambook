// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'dart:math';

import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'transform.g.dart';

final transformItem = CodeItem(
  title: (context) => 'Transform',
  code: const TheCode(),
  widget: const TheWidget(),
);

enum TransformType {
  flip,
  rotate,
  scale,
  translate,
}

class TransformConfig {
  TransformConfig({
    this.type = TransformType.translate,
    this.flipX = false,
    this.flipY = false,
    this.angle = 0.0,
    this.scaleX = 1,
    this.scaleY = 1,
    this.offsetX = 0.0,
    this.offsetY = 0.0,
  });

  final TransformType type;
  final bool flipX;
  final bool flipY;
  final double angle;
  final double scaleX;
  final double scaleY;
  final double offsetX;
  final double offsetY;

  TransformConfig copyWith({
    TransformType? type,
    bool? flipX,
    bool? flipY,
    double? angle,
    double? scaleX,
    double? scaleY,
    double? offsetX,
    double? offsetY,
  }) {
    return TransformConfig(
      type: type ?? this.type,
      flipX: flipX ?? this.flipX,
      flipY: flipY ?? this.flipY,
      angle: angle ?? this.angle,
      scaleX: scaleX ?? this.scaleX,
      scaleY: scaleY ?? this.scaleY,
      offsetX: offsetX ?? this.offsetX,
      offsetY: offsetY ?? this.offsetY,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  TransformConfig build() => TransformConfig();
  void change(TransformConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'Transform.${config.type.name}',
      named: {
        ...switch (config.type) {
          TransformType.flip => {
              'flipX': refer(config.flipX.toString()),
              'flipY': refer(config.flipY.toString()),
            },
          TransformType.rotate => {
              'angle': refer(config.angle.toStringAsFixed(2)),
            },
          TransformType.scale => {
              'scaleX': refer(config.scaleX.toStringAsFixed(2)),
              'scaleY': refer(config.scaleY.toStringAsFixed(2)),
            },
          TransformType.translate => {
              'offsetX': refer(config.offsetX.toStringAsFixed(2)),
              'offsetY': refer(config.offsetY.toStringAsFixed(2)),
            },
        },
        'child': refer('const FlutterLogo(size: 128)'),
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    const child = FlutterLogo(size: 128);
    return WidgetWithConfiguration(
      content: switch (config.type) {
        TransformType.flip => Transform.flip(
            flipX: config.flipX,
            flipY: config.flipY,
            child: child,
          ),
        TransformType.rotate => Transform.rotate(
            angle: config.angle,
            child: child,
          ),
        TransformType.scale => Transform.scale(
            scaleX: config.scaleX,
            scaleY: config.scaleY,
            child: child,
          ),
        TransformType.translate => Transform.translate(
            offset: Offset(config.offsetX, config.offsetY),
            child: child,
          ),
      },
      configs: [
        MenuTile(
          title: context.tr.theType,
          items: TransformType.values,
          current: config.type,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(type: t));
          },
          contentBuilder: (t) => t.name,
        ),
        ...switch (config.type) {
          TransformType.flip => [
              SwitchListTile(
                title: const Text('Flip X'),
                value: config.flipX,
                onChanged: (t) {
                  ref
                      .read(configProvider.notifier)
                      .change(config.copyWith(flipX: t));
                },
              ),
              SwitchListTile(
                title: const Text('Flip Y'),
                value: config.flipY,
                onChanged: (t) {
                  ref
                      .read(configProvider.notifier)
                      .change(config.copyWith(flipY: t));
                },
              ),
            ],
          TransformType.rotate => [
              SlidableTile(
                title: 'Angle',
                value: config.angle,
                max: pi * 2,
                onChanged: (t) {
                  ref
                      .read(configProvider.notifier)
                      .change(config.copyWith(angle: t));
                },
              ),
            ],
          TransformType.scale => [
              SlidableTile(
                title: 'Scale X',
                value: config.scaleX,
                max: 2,
                onChanged: (t) {
                  ref
                      .read(configProvider.notifier)
                      .change(config.copyWith(scaleX: t));
                },
              ),
              SlidableTile(
                title: 'Scale Y',
                value: config.scaleY,
                max: 2,
                onChanged: (t) {
                  ref
                      .read(configProvider.notifier)
                      .change(config.copyWith(scaleY: t));
                },
              ),
            ],
          TransformType.translate => [
              SlidableTile(
                title: 'Offset X',
                min: -100,
                max: 100,
                value: config.offsetX,
                onChanged: (t) {
                  ref
                      .read(configProvider.notifier)
                      .change(config.copyWith(offsetX: t));
                },
              ),
              SlidableTile(
                title: 'Offset Y',
                value: config.offsetY,
                min: -100,
                max: 100,
                onChanged: (t) {
                  ref
                      .read(configProvider.notifier)
                      .change(config.copyWith(offsetY: t));
                },
              ),
            ],
        }
      ],
    );
  }
}
