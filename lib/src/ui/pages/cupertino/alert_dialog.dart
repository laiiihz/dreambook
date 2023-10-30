// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'alert_dialog.g.dart';

final alertDialogItem = CodeItem(
  title: (context) => 'Alert Dialog',
  code: const TheCode(),
  widget: const TheWidget(),
);

class AlertDialogConfig {
  AlertDialogConfig({
    this.showContent = false,
    this.showActions = false,
  });

  final bool showContent;
  final bool showActions;

  AlertDialogConfig copyWith({
    bool? showContent,
    bool? showActions,
  }) {
    return AlertDialogConfig(
      showContent: showContent ?? this.showContent,
      showActions: showActions ?? this.showActions,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  AlertDialogConfig build() => AlertDialogConfig();
  void change(AlertDialogConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'CupertinoAlertDialog',
      named: {
        'title': refer("const Text('Title')"),
        if (config.showContent) 'content': refer("const Text('Content')"),
        if (config.showActions)
          'actions': literalList([
            InvokeExpression.newOf(
              refer('CupertinoDialogAction'),
              [],
              {
                'onPressed': refer('() {}'),
                'child':
                    refer("const Text('${context.mtr.cancelButtonLabel}')"),
              },
            ),
            InvokeExpression.newOf(
              refer('CupertinoDialogAction'),
              [],
              {
                'onPressed': refer('() {}'),
                'child': refer("const Text('${context.mtr.okButtonLabel}')"),
              },
            ),
          ])
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
      background: true,
      initialFractions: const [0.5, 0.5],
      content: CupertinoAlertDialog(
        title: const Text('data'),
        content: config.showContent ? const Text('Content') : null,
        actions: config.showActions
            ? [
                CupertinoDialogAction(
                  child: Text(context.mtr.cancelButtonLabel),
                  onPressed: () {},
                ),
                CupertinoDialogAction(
                    child: Text(context.mtr.okButtonLabel), onPressed: () {}),
              ]
            : [],
      ),
      configs: [
        SwitchListTile(
          title: const Text('show Content'),
          value: config.showContent,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showContent: t));
          },
        ),
        SwitchListTile(
          title: const Text('show Actions'),
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
