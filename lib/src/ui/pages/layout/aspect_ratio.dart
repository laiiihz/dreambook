// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:dreambook/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'aspect_ratio.g.dart';

final aspectRatioItem = CodeItem(
  title: (context) => context.tr.aspectRatio,
  code: const TheCode(),
  widget: const TheWidget(),
);

class AspectRatioConfig {
  AspectRatioConfig({
    this.aspectRatio = 1,
  });

  final double aspectRatio;

  AspectRatioConfig copyWith({
    double? aspectRatio,
  }) {
    return AspectRatioConfig(
      aspectRatio: aspectRatio ?? this.aspectRatio,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  AspectRatioConfig build() => AspectRatioConfig();
  void change(AspectRatioConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final aspectRatio = config.aspectRatio.readableStr();
    return AutoCode(
      'AspectRatio',
      apiUrl: '/flutter/widgets/AspectRatio-class.html',
      named: {
        if (aspectRatio != '1') 'aspectRatio': refer(aspectRatio),
        'child': refer(
            'Container(color: Theme.of(context).colorScheme.primaryContainer)'),
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
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 240, maxHeight: 240),
        child: AspectRatio(
          aspectRatio: config.aspectRatio,
          child:
              Container(color: Theme.of(context).colorScheme.primaryContainer),
        ),
      ),
      configs: [
        SlidableTile(
          title: context.tr.aspectRatio,
          value: config.aspectRatio,
          min: 0.5,
          max: 2,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(aspectRatio: t));
          },
        ),
      ],
    );
  }
}
