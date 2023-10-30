// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_builder_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'popup_menu_button.g.dart';

final popupMenuButtonItem = CodeItem(
  title: (context) => context.tr.popupMenuButton,
  code: const TheCode(),
  widget: const TheWidget(),
);

class PopupMenuButtonConfig {
  PopupMenuButtonConfig({this.hasInitial = false});

  final bool hasInitial;

  PopupMenuButtonConfig copyWith({
    bool? hasInitial,
  }) {
    return PopupMenuButtonConfig(
      hasInitial: hasInitial ?? this.hasInitial,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  PopupMenuButtonConfig build() => PopupMenuButtonConfig();
  void change(PopupMenuButtonConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'PopupMenuButton<int>',
      fields: [
        Field((f) => f
          ..name = 'currentItem'
          ..type = refer('int?')),
      ],
      named: {
        if (config.hasInitial) 'initialValue': refer('currentItem'),
        'itemBuilder': Method((m) => m
          ..requiredParameters.add(Parameter((p) => p..name = 'context'))
          ..body = Block((b) => b.addExpression(InvokeExpression.newOf(
              refer('List'),
              [
                refer('4'),
                Method((m) => m
                  ..lambda = true
                  ..requiredParameters.add(Parameter((p) => p.name = 'index'))
                  ..body = InvokeExpression.newOf(refer('PopupMenuItem'), [], {
                    'value': refer('index'),
                    'child': refer(r"Text('item $index')")
                  }).code).closure,
              ],
              {},
              [],
              'generate')))).closure,
        'onSelected': Method((m) => m
          ..body = Block((b) {
            b.addExpression(CodeHelper.setState('currentItem = value'));
          })
          ..requiredParameters.add(Parameter((p) => p.name = 'value'))).closure,
      },
    );
  }
}

@riverpod
class InitValue extends _$InitValue {
  @override
  int? build() => null;

  void change(int value) {
    state = value;
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: PopupMenuButton<int>(
        initialValue: config.hasInitial ? ref.watch(initValueProvider) : null,
        itemBuilder: (context) {
          return List.generate(
            4,
            (index) => PopupMenuItem(value: index, child: Text('item $index')),
          );
        },
        onSelected: (value) {
          ref.read(initValueProvider.notifier).change(value);
        },
      ),
      configs: [
        SwitchListTile(
          title: const Text('has initial value'),
          value: config.hasInitial,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(hasInitial: t));
          },
        ),
      ],
    );
  }
}
