// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'switch.g.dart';

final switchItem = CodeItem(
  title: (context) => context.tr.switchItem,
  code: const TheCode(),
  widget: const TheWidget(),
);

class ListTileConfig {
  ListTileConfig({this.enabled = true});
  final bool enabled;

  ListTileConfig copyWith({
    bool? enabled,
  }) {
    return ListTileConfig(
      enabled: enabled ?? this.enabled,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  ListTileConfig build() => ListTileConfig();

  void change(ListTileConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'Switch',
      fields: [
        Field((f) => f
          ..name = 'state'
          ..type = refer('bool')
          ..assignment = const Code('false')),
      ],
      named: {
        'value': refer('state'),
        'onChanged': config.enabled
            ? Method((m) => m
              ..lambda = false
              ..requiredParameters.add(Parameter((p) => p.name = 'value'))
              ..body = Block((b) {
                b.addExpression(InvokeExpression.newOf(refer('setState'), [
                  Method((m) => m
                    ..body = Block((b) {
                      b.addExpression(refer('state = value'));
                    })).closure,
                ]));
              })).closure
            : refer('null'),
      },
    );
  }
}

@riverpod
class SwitchState extends _$SwitchState {
  @override
  bool build() => false;

  void change(bool value) {
    state = value;
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: Switch(
        value: ref.watch(switchStateProvider),
        onChanged: config.enabled
            ? (value) {
                ref.read(switchStateProvider.notifier).change(value);
              }
            : null,
      ),
      configs: [
        SwitchListTile(
          title: Text(context.tr.enabled),
          value: config.enabled,
          onChanged: (value) {
            ref
                .watch(configProvider.notifier)
                .change(config.copyWith(enabled: value));
          },
        )
      ],
    );
  }
}
