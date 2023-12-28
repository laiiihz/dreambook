// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:dreambook/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'circle_avatar.g.dart';

final circleAvatarItem = CodeItem(
  title: (context) => 'Circle Avatar',
  code: const TheCode(),
  widget: const TheWidget(),
);

class CircleAvatarConfig {
  CircleAvatarConfig({
    this.radius = 48,
  });

  final double radius;

  CircleAvatarConfig copyWith({
    double? radius,
  }) {
    return CircleAvatarConfig(
      radius: radius ?? this.radius,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  CircleAvatarConfig build() => CircleAvatarConfig();
  void change(CircleAvatarConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final radius = config.radius.readableStr(0);
    return AutoCode(
      'CircleAvatar',
      named: {
        'radius': refer(radius),
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
      content: CircleAvatar(radius: config.radius),
      configs: [
        SlidableTile(
          title: 'Radius',
          value: config.radius,
          max: 128,
          min: 24,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(radius: t));
          },
        ),
      ],
    );
  }
}
