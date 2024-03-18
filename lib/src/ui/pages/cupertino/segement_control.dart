// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/imports.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_builder_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'segement_control.g.dart';

final segmentedControlItem = CodeItem(
  title: (context) => context.tr.segmentedControl,
  code: const TheCode(),
  widget: const TheWidget(),
);

class SegementedControlConfig {
  SegementedControlConfig({
    this.slidable = false,
  });

  final bool slidable;

  SegementedControlConfig copyWith({
    bool? slidable,
  }) {
    return SegementedControlConfig(
      slidable: slidable ?? this.slidable,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  SegementedControlConfig build() => SegementedControlConfig();
  void change(SegementedControlConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);

    Code code(String tag) {
      return Code('''Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('Item $tag'))''');
    }

    return AutoCode(
      config.slidable
          ? 'CupertinoSlidingSegmentedControl<int>'
          : 'CupertinoSegmentedControl<int>',
      import: Imports.cupertino,
      fields: [
        Field((f) => f
          ..name = 'groupValue'
          ..type = refer('int?')),
      ],
      named: {
        'children': literalConstMap({1: code('A'), 2: code('B'), 3: code('C')}),
        'groupValue': refer('groupValue'),
        'onValueChanged': Method((m) {
          m.requiredParameters.add(Parameter((p) => p
            ..type = refer('int')
            ..name = 'value'));
          m.body = Block((b) {
            b.addExpression(CodeHelper.setState('groupValue = value'));
          });
        }).closure,
      },
      apiUrl: '/flutter/cupertino/CupertinoSegmentedControl-class.html',
    );
  }
}

@riverpod
class TheGroupValue extends _$TheGroupValue {
  @override
  int? build() => null;

  void update(int? value) {
    state = value;
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);

    const children = {
      1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Item A')),
      2: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Item B')),
      3: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Item C')),
    };
    return WidgetWithConfiguration(
      content: config.slidable
          ? CupertinoSlidingSegmentedControl<int>(
              children: children,
              groupValue: ref.watch(theGroupValueProvider),
              onValueChanged: (t) {
                ref.read(theGroupValueProvider.notifier).update(t);
              },
            )
          : CupertinoSegmentedControl<int>(
              children: children,
              groupValue: ref.watch(theGroupValueProvider),
              onValueChanged: (t) {
                ref.read(theGroupValueProvider.notifier).update(t);
              },
            ),
      configs: [
        SwitchListTile(
          title: const Text('slidable control'),
          value: config.slidable,
          onChanged: (value) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(slidable: value));
          },
        ),
      ],
    );
  }
}
