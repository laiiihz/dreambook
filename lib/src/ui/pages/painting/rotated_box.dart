// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';

part 'rotated_box.g.dart';

final rotatedBoxItem = CodeItem(
  title: (context) => context.tr.rotatedBox,
  code: const TheCode(),
  widget: const TheWidget(),
);

class RotatedBoxConfig {
  RotatedBoxConfig({
    this.quarterTurns = 0,
  });

  final int quarterTurns;

  RotatedBoxConfig copyWith({
    int? quarterTurns,
  }) {
    return RotatedBoxConfig(
      quarterTurns: quarterTurns ?? this.quarterTurns,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  RotatedBoxConfig build() => RotatedBoxConfig();
  void change(RotatedBoxConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'RotatedBox',
      named: {
        'quarterTurns': refer(config.quarterTurns.toString()),
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
    return WidgetWithConfiguration(
      content: RotatedBox(
        quarterTurns: config.quarterTurns,
        child: const FlutterLogo(size: 128),
      ),
      configs: [
        SlidableTile(
          title: 'Quarter Turns',
          value: config.quarterTurns + .0,
          max: 4,
          divisions: 4,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(quarterTurns: t.toInt()));
          },
        ),
      ],
    );
  }
}
