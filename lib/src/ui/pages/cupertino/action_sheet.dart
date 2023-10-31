// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'action_sheet.g.dart';

final actionSheetItem = CodeItem(
  title: (context) => context.tr.actionSheet,
  code: const TheCode(),
  widget: const TheWidget(),
);

class ExampleConfig {
  ExampleConfig({
    this.showMessage = false,
    this.showCancel = false,
    this.showActions = false,
  });

  final bool showMessage;
  final bool showCancel;
  final bool showActions;

  ExampleConfig copyWith({
    bool? showMessage,
    bool? showCancel,
    bool? showActions,
  }) {
    return ExampleConfig(
      showMessage: showMessage ?? this.showMessage,
      showCancel: showCancel ?? this.showCancel,
      showActions: showActions ?? this.showActions,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  ExampleConfig build() => ExampleConfig();
  void change(ExampleConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'ActionSheet',
      named: {
        'title': refer("const Text('title')"),
        if (config.showMessage) 'message': refer("const Text('a message')"),
        if (config.showActions)
          'actions': literalList(
            List.generate(
              4,
              (index) => InvokeExpression.newOf(
                  refer('CupertinoActionSheetAction'), [], {
                'onPressed': refer('(){}'),
                'child': refer("Text('Item $index')"),
              }),
            ),
          ),
        if (config.showCancel)
          'cancelButton':
              refer("const Text('${context.mtr.cancelButtonLabel}')"),
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
      background: true,
      content: CupertinoActionSheet(
        title: const Text('Title'),
        message: config.showMessage ? const Text('a message') : null,
        actions: config.showActions
            ? List.generate(
                4,
                (index) => CupertinoActionSheetAction(
                  onPressed: () {},
                  child: Text('Item $index'),
                ),
              )
            : null,
        cancelButton: config.showCancel
            ? CupertinoActionSheetAction(
                onPressed: () {}, child: Text(context.mtr.cancelButtonLabel))
            : null,
      ),
      configs: [
        SwitchListTile(
          title: const Text('Show Message'),
          value: config.showMessage,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showMessage: t));
          },
        ),
        SwitchListTile(
          title: const Text('Show Cancel Button'),
          value: config.showCancel,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showCancel: t));
          },
        ),
        SwitchListTile(
          title: const Text('Show Actions'),
          value: config.showActions,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showActions: t));
          },
        ),
      ],
    );
  }
}
