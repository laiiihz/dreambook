// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'placeholder.g.dart';

final placeholderItem = CodeItem(
  title: (context) => context.tr.placeholder,
  code: const TheCode(),
  widget: const TheWidget(),
);

class PlaceholderConfig {
  PlaceholderConfig({
    this.width = 2,
  });

  final double width;

  PlaceholderConfig copyWith({
    double? width,
  }) {
    return PlaceholderConfig(
      width: width ?? this.width,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  PlaceholderConfig build() => PlaceholderConfig();
  void change(PlaceholderConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'Placeholder',
      named: {
        'width': refer(config.width.toStringAsFixed(2)),
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
      content: Placeholder(
        strokeWidth: config.width,
      ),
      configs: [
        SlidableTile(
          title: 'Stroke Width',
          value: config.width,
          min: 0.5,
          max: 32,
          onChanged: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(width: t));
          },
        ),
      ],
    );
  }
}
