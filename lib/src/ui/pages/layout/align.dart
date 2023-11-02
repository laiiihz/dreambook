// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';

part 'align.g.dart';

final alignItem = CodeItem(
  title: (context) => context.tr.alignment,
  code: const TheCode(),
  widget: const TheWidget(),
);

class AlignConfig {
  AlignConfig({
    this.alignment = Alignment.center,
  });
  final Alignment alignment;

  AlignConfig copyWith({
    Alignment? alignment,
  }) {
    return AlignConfig(
      alignment: alignment ?? this.alignment,
    );
  }
}

extension on Alignment {
  String get name {
    return switch (this) {
      Alignment.topLeft => 'topLeft',
      Alignment.topCenter => 'topCenter',
      Alignment.topRight => 'topRight',
      Alignment.centerLeft => 'centerLeft',
      Alignment.center => 'center',
      Alignment.centerRight => 'centerRight',
      Alignment.bottomLeft => 'bottomLeft',
      Alignment.bottomCenter => 'bottomCenter',
      Alignment.bottomRight => 'bottomRight',
      _ => 'Value',
    };
  }
}

@riverpod
class Config extends _$Config {
  @override
  AlignConfig build() => AlignConfig();
  void change(AlignConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'Alignment',
      named: {
        'alignment': refer('Alignment.${config.alignment.name}'),
        'child': refer('FlutterLogo(size: 64)'),
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
      content: SizedBox.expand(
        child: Align(
          alignment: config.alignment,
          child: const FlutterLogo(size: 64),
        ),
      ),
      configs: [
        MenuTile<Alignment>(
          title: context.tr.alignment,
          items: const [
            Alignment.topLeft,
            Alignment.topCenter,
            Alignment.topRight,
            Alignment.centerLeft,
            Alignment.center,
            Alignment.centerRight,
            Alignment.bottomLeft,
            Alignment.bottomCenter,
            Alignment.bottomRight,
          ],
          current: config.alignment,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(alignment: t));
          },
          contentBuilder: (t) => t.name,
        ),
      ],
    );
  }
}
