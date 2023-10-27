// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_builder_helper.dart';
import 'package:dreambook/src/utils/code_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'switch.g.dart';

final switchItem = CodeItem(
  title: 'Switch',
  code: const TheCode(),
  widget: const TheWidget(),
);

class SwitchConfig {
  SwitchConfig({
    this.enabled = true,
  });

  final bool enabled;

  SwitchConfig copyWith({
    bool? enabled,
  }) {
    return SwitchConfig(
      enabled: enabled ?? this.enabled,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  SwitchConfig build() => SwitchConfig();
  void change(SwitchConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'CupertinoSwitch',
      import: Imports.cupertino,
      fields: [
        Field(
          (f) => f
            ..name = 'state'
            ..type = refer('bool')
            ..assignment = const Code('false'),
        ),
      ],
      named: {
        'onChanged': config.enabled
            ? Method((m) => m
                  ..requiredParameters.add(Parameter((p) => p..name = 'value'))
                  ..body = Block((b) =>
                      b.addExpression(CodeHelper.setState('state = value'))))
                .closure
            : refer('null'),
      },
    );
  }
}

class TheWidget extends ConsumerStatefulWidget {
  const TheWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TheWidgetState();
}

class _TheWidgetState extends ConsumerState<TheWidget> {
  bool state = false;
  @override
  Widget build(BuildContext context) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: CupertinoSwitch(
        value: state,
        onChanged: config.enabled
            ? (t) {
                setState(() => state = t);
              }
            : null,
      ),
      configs: [
        SwitchListTile(
          title: const Text('Enabled'),
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
