// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';

part 'slider.g.dart';

final sliderItem = CodeItem(
  title: (context) => context.tr.slider,
  code: const TheCode(),
  widget: const TheWidget(),
);

class SliderConfig {
  SliderConfig({
    this.hasDivision = false,
    this.interaction = SliderInteraction.tapAndSlide,
    this.enabled = true,
  });
  final bool hasDivision;
  final SliderInteraction interaction;
  final bool enabled;

  SliderConfig copyWith({
    bool? hasDivision,
    SliderInteraction? interaction,
    bool? enabled,
  }) {
    return SliderConfig(
      hasDivision: hasDivision ?? this.hasDivision,
      interaction: interaction ?? this.interaction,
      enabled: enabled ?? this.enabled,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  SliderConfig build() => SliderConfig();
  void change(SliderConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'Slider',
      fields: [
        Field((f) => f
          ..name = 'state'
          ..type = refer('double')
          ..assignment = const Code('0')),
      ],
      named: {
        'value': refer('state'),
        if (config.hasDivision) 'divisions': refer('8'),
        if (config.interaction != SliderInteraction.tapAndSlide)
          'allowedInteraction':
              refer('SliderInteraction.${config.interaction.name}'),
        'onChanged': config.enabled
            ? Method((m) => m.body = Block((b) =>
                    b.addExpression(refer('SetState(() => state = value)'))))
                .closure
            : refer('null'),
      },
    );
  }
}

@riverpod
class TheValue extends _$TheValue {
  @override
  double build() => 0;

  void change(double value) {
    state = value;
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: Slider(
        value: ref.watch(theValueProvider),
        divisions: config.hasDivision ? 8 : null,
        allowedInteraction: config.interaction,
        onChanged: config.enabled
            ? (t) {
                ref.read(theValueProvider.notifier).change(t);
              }
            : null,
      ),
      configs: [
        SwitchListTile(
          title: const Text('Has Division'),
          value: config.hasDivision,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(hasDivision: t));
          },
        ),
        MenuTile(
          title: 'Interaction',
          items: SliderInteraction.values,
          current: config.interaction,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(interaction: t));
          },
          contentBuilder: (t) => t.name,
        ),
        SwitchListTile(
          title: Text(context.tr.enabled),
          value: config.enabled,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(enabled: t));
          },
        ),
      ],
    );
  }
}
