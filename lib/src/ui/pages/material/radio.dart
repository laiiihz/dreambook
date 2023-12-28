// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_builder_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'radio.g.dart';

final radioItem = CodeItem(
  title: (context) => context.tr.radio,
  code: const TheCode(),
  widget: const TheWidget(),
);

class RadioConfig {
  RadioConfig({this.toggleable = false});

  final bool toggleable;

  RadioConfig copyWith({
    bool? toggleable,
  }) {
    return RadioConfig(
      toggleable: toggleable ?? this.toggleable,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  RadioConfig build() => RadioConfig();
  void change(RadioConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'ListView',
      apiUrl: '/flutter/material/Radio-class.html',
      fields: [
        Field((f) => f
          ..name = 'value'
          ..type = refer('int?'))
      ],
      named: {
        'children': InvokeExpression.newOf(
          refer('List'),
          [
            refer('3'),
            Method((m) => m
              ..requiredParameters.add(Parameter((p) => p.name = 'index'))
              ..lambda = true
              ..body = InvokeExpression.newOf(
                refer('ListTile'),
                [],
                {
                  'leading': InvokeExpression.newOf(refer('Radio<int>'), [], {
                    if (config.toggleable) 'toggleable': literalTrue,
                    'value': refer('index'),
                    'groupValue': refer('value'),
                    'onChanged': Method((m) => m
                          ..requiredParameters
                              .add(Parameter((p) => p..name = 'item'))
                          ..body = CodeHelper.setState('value = item').code)
                        .closure,
                  }),
                  'title': refer(r"Text('Item $index')"),
                },
              ).code).closure,
          ],
          {},
          [],
          'generate',
        ),
      },
    );
  }
}

@riverpod
class CurrentItem extends _$CurrentItem {
  @override
  int? build() => null;

  void change(int? config) {
    state = config;
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: ListView(
        children: List.generate(
          3,
          (index) => ListTile(
            leading: Radio<int>(
              toggleable: true,
              value: index,
              groupValue: ref.watch(currentItemProvider),
              onChanged: (t) {
                ref.read(currentItemProvider.notifier).change(t);
              },
            ),
            title: Text('Item $index'),
          ),
        ),
      ),
      configs: [
        SwitchListTile(
            title: const Text('Toggleable'),
            value: config.toggleable,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(toggleable: t));
            }),
      ],
    );
  }
}
