// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'button.g.dart';

final buttonItem = CodeItem(
  title: (context) => context.tr.button,
  code: const TheCode(),
  widget: const TheWidget(),
);

enum ButtonType {
  normal('CupertinoButton'),
  filled('CupertinoButton.fiiled'),
  ;

  const ButtonType(this.code);
  final String code;
}

class ButtonConfig {
  ButtonConfig({
    this.type = ButtonType.normal,
    this.canTap = true,
  });

  final ButtonType type;
  final bool canTap;

  ButtonConfig copyWith({
    ButtonType? type,
    bool? canTap,
  }) {
    return ButtonConfig(
      type: type ?? this.type,
      canTap: canTap ?? this.canTap,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  ButtonConfig build() => ButtonConfig();
  void change(ButtonConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      config.type.code,
      apiUrl: '/flutter/cupertino/CupertinoButton-class.html',
      named: {
        'onPressed': config.canTap ? refer('() {}') : refer('null'),
        'child': refer("Text('${config.type.code}')"),
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final onPressed = config.canTap ? () {} : null;
    final child = Text(config.type.code);
    return WidgetWithConfiguration(
      content: switch (config.type) {
        ButtonType.normal => CupertinoButton(
            onPressed: onPressed,
            child: child,
          ),
        ButtonType.filled => CupertinoButton.filled(
            onPressed: onPressed,
            child: child,
          ),
      },
      configs: [
        MenuTile(
          title: context.tr.theType,
          items: ButtonType.values,
          current: config.type,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(type: t));
          },
          contentBuilder: (t) => t.name,
        ),
        SwitchListTile(
          title: const Text('can tap'),
          value: config.canTap,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(canTap: t));
          },
        ),
      ],
    );
  }
}
