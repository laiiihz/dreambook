// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_builder_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checkbox.g.dart';

final checkboxItem = CodeItem(
  title: (context) => context.tr.checkBox,
  code: const TheCode(),
  widget: const TheWidget(),
);

class CheckboxConfig {
  CheckboxConfig({this.tristate = false});
  final bool tristate;

  CheckboxConfig copyWith({
    bool? tristate,
  }) {
    return CheckboxConfig(
      tristate: tristate ?? this.tristate,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  CheckboxConfig build() => CheckboxConfig();
  void change(CheckboxConfig config) {
    state = config;
  }
}

@riverpod
class TheState extends _$TheState {
  @override
  bool? build() => false;
  void change(bool? value) {
    state = value;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'Checkbox',
      prefix: [
        Field((f) => f
          ..name = 'state'
          ..type = refer('bool?')
          ..assignment = const Code('false')),
      ],
      named: {
        'value': refer('state'),
        if (config.tristate) 'tristate': refer('true'),
        'onChanged': Method((m) => m
              ..requiredParameters.add(Parameter((p) => p
                ..name = 'value'
                ..type = refer('bool?')))
              ..body = Block(
                  (b) => b.addExpression(CodeHelper.setState('state = value'))))
            .closure,
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
      content: Checkbox(
        tristate: config.tristate,
        value: ref.watch(theStateProvider),
        onChanged: (state) {
          ref.read(theStateProvider.notifier).change(state);
        },
      ),
      configs: [
        SwitchListTile(
          title: const Text('tristate'),
          value: config.tristate,
          onChanged: (t) {
            if (!t) {
              ref.read(theStateProvider.notifier).change(false);
            }
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(tristate: t));
          },
        ),
      ],
    );
  }
}
