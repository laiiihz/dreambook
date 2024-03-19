// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/engine/painting.dart';
import 'package:dreambook/src/codes/widgets/icon.dart';
import 'package:dreambook/src/codes/widgets/stateful_widget.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_area.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'icon.g.dart';

final iconItem = CodeItem(
  title: (context) => context.tr.icons,
  code: const TheCode(),
  widget: const TheWidget(),
);

class IconConfig {
  IconConfig({
    this.hasColor = false,
    this.size = 18,
    this.hasShadow = false,
  });
  final bool hasColor;
  final double size;
  final bool hasShadow;

  IconConfig copyWith({
    bool? hasColor,
    double? size,
    bool? hasShadow,
  }) {
    return IconConfig(
      hasColor: hasColor ?? this.hasColor,
      size: size ?? this.size,
      hasShadow: hasShadow ?? this.hasShadow,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  IconConfig build() => IconConfig();
  void change(IconConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return CodeArea(
      api: 'flutter/widgets/Icon-class.html',
      codes: [
        StatefulWidgetX(
          buildReturn: IconX(
            refer('Icons').property('favorite'),
            color: config.hasColor ? Colors.blue : null,
            size: config.size != 18 ? config.size : null,
            shadows$: config.hasShadow
                ? [
                    ShadowX(
                      color$: refer('Theme')
                          .newInstanceNamed('of', [refer('context')])
                          .property('colorScheme')
                          .property('outline'),
                      offset: const Offset(2, 2),
                      blurRadius: 8,
                    ),
                  ]
                : null,
          ),
        ),
      ],
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: Icon(
        Icons.favorite,
        size: config.size,
        color: config.hasColor ? Colors.blue : null,
        shadows: config.hasShadow
            ? [
                Shadow(
                  color: Theme.of(context).colorScheme.outline,
                  offset: const Offset(2, 2),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
      configs: [
        SwitchListTile(
          title: const Text('Has Color'),
          value: config.hasColor,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(hasColor: t));
          },
        ),
        SlidableTile(
          title: 'Size',
          value: config.size,
          min: 8,
          max: 40,
          divisions: 16,
          onChanged: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(size: t));
          },
        ),
        SwitchListTile(
          title: const Text('Has Shadow'),
          value: config.hasShadow,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(hasShadow: t));
          },
        ),
      ],
    );
  }
}
