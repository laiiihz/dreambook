// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'snack_bar.g.dart';

final snackBarItem = CodeItem(
  title: 'Snack Bar',
  code: const TheCode(),
  widget: const TheWidget(),
);

class SnackBarConfig {
  SnackBarConfig({
    this.showAction = false,
    this.showClose = false,
    this.dismissDirection = DismissDirection.down,
  });

  final bool showAction;
  final bool showClose;
  final DismissDirection dismissDirection;

  SnackBarConfig copyWith({
    bool? showAction,
    bool? showClose,
    DismissDirection? dismissDirection,
  }) {
    return SnackBarConfig(
      showAction: showAction ?? this.showAction,
      showClose: showClose ?? this.showClose,
      dismissDirection: dismissDirection ?? this.dismissDirection,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  SnackBarConfig build() => SnackBarConfig();

  void change(SnackBarConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'FilledButton',
      named: {
        'onPressed': Method((m) => m
          ..body = Block((b) => b.addExpression(
                InvokeExpression.newOf(
                  refer('ScaffoldMessager.of(context)'),
                  [
                    InvokeExpression.newOf(
                      refer('SnackBar'),
                      [],
                      {
                        'content': refer("const Text('content')"),
                        if (config.showClose) 'showCloseIcon': refer('true'),
                        if (config.dismissDirection != DismissDirection.down)
                          'dismissDirection': refer(
                              'DismissDirection.${config.dismissDirection.name}'),
                        if (config.showAction)
                          'actions': refer(
                              "SnackBarAction(label: 'Action',onPressed: () {})"),
                      },
                    ),
                  ],
                  {},
                  [],
                  'showSnackBar',
                ),
              ))).closure,
        'child': refer("const Text('Open SnackBar')"),
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
      content: FilledButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('content'),
            showCloseIcon: config.showClose,
            dismissDirection: config.dismissDirection,
            action: config.showAction
                ? SnackBarAction(
                    label: 'Action',
                    onPressed: () {},
                  )
                : null,
          ));
        },
        child: const Text('Open SnackBar'),
      ),
      configs: [
        SwitchListTile(
          title: const Text('show close'),
          value: config.showClose,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showClose: t));
          },
        ),
        SwitchListTile(
          title: const Text('show action'),
          value: config.showAction,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showAction: t));
          },
        ),
        MenuTile<DismissDirection>(
          title: 'Dismiss Direction',
          items: DismissDirection.values,
          current: config.dismissDirection,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(dismissDirection: t));
          },
          contentBuilder: (t) => t.name,
        ),
      ],
    );
  }
}
