// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'action_buttons.g.dart';

final actionButtonsItem = CodeItem(
  title: (context) => 'Action Buttons',
  code: const TheCode(),
  widget: const TheWidget(),
);

enum ActionButtonType {
  back('BackButton'),
  close('CloseButton'),
  drawer('DrawerButton'),
  endDrawer('EndDrawerButton'),
  ;

  const ActionButtonType(this.rawName);

  final String rawName;
}

class ActionButtonsConfig {
  ActionButtonsConfig({
    this.type = ActionButtonType.back,
  });

  final ActionButtonType type;

  ActionButtonsConfig copyWith({
    ActionButtonType? type,
  }) {
    return ActionButtonsConfig(
      type: type ?? this.type,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  ActionButtonsConfig build() => ActionButtonsConfig();
  void change(ActionButtonsConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(config.type.rawName);
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: switch (config.type) {
        ActionButtonType.back => const BackButton(),
        ActionButtonType.close => const CloseButton(),
        ActionButtonType.drawer => const DrawerButton(),
        ActionButtonType.endDrawer => const EndDrawerButton(),
      },
      configs: [
        MenuTile(
          title: context.tr.theType,
          items: ActionButtonType.values,
          current: config.type,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(type: t));
          },
          contentBuilder: (t) => t.name,
        ),
      ],
    );
  }
}
