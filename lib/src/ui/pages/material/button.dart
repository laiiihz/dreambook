// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'button.g.dart';

enum ButtonType {
  text('TextButton'),
  textIcon('TextButton.icon'),
  filled('FilledButton'),
  filledIcon('FilledButton.icon'),
  filledTonal('FilledButton.tonal'),
  filledTonalIcon('FilledButton.tonalIcon'),
  elevated('ElevatedButton'),
  elevatedIcon('ElevatedButton.icon'),
  outlined('OutlinedButton'),
  outlinedIcon('OutlinedButton.icon'),
  icon('IconButton'),
  iconFilled('IconButton.filled'),
  iconFilledTonal('OutlinedButton.filledTonal'),
  iconOutlined('IconButton.outlined'),
  ;

  const ButtonType(this.contentName);
  final String contentName;

  bool get hasIcon {
    return switch (this) {
      ButtonType.textIcon ||
      ButtonType.elevatedIcon ||
      ButtonType.filledIcon ||
      ButtonType.filledTonalIcon ||
      ButtonType.outlinedIcon ||
      ButtonType.icon ||
      ButtonType.iconFilled ||
      ButtonType.iconFilledTonal ||
      ButtonType.iconOutlined =>
        true,
      _ => false,
    };
  }

  bool get isIconButton {
    return switch (this) {
      ButtonType.icon ||
      ButtonType.iconFilled ||
      ButtonType.iconFilledTonal ||
      ButtonType.iconOutlined =>
        true,
      _ => false,
    };
  }
}

class ButtonConfig {
  ButtonConfig({
    this.enabled = true,
    this.type = ButtonType.filledIcon,
  });

  final bool enabled;
  final ButtonType type;

  ButtonConfig copyWith({
    bool? enabled,
    ButtonType? type,
  }) {
    return ButtonConfig(
      enabled: enabled ?? this.enabled,
      type: type ?? this.type,
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

final buttonItem = CodeItem(
  title: (context) => context.tr.button,
  code: const TheCode(),
  widget: const TheWidget(),
);

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      config.type.contentName,
      named: {
        'onPressed': config.enabled ? refer('() {}') : refer('null'),
        if (config.type.hasIcon) 'icon': refer('Icon(Icons.category_rounded)'),
        if (!config.type.isIconButton)
          if (config.type.hasIcon)
            'label': refer('Text(\'${config.type.contentName}\')')
          else
            'child': refer('Text(\'${config.type.contentName}\')'),
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
      content: const TheButton(),
      configs: [
        MenuTile<ButtonType>(
          title: 'Type',
          current: config.type,
          items: ButtonType.values,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(type: t));
          },
          contentBuilder: (t) => t.contentName,
        ),
        SwitchListTile(
          title: Text(context.tr.enabled),
          value: config.enabled,
          onChanged: (state) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(enabled: state));
          },
        ),
      ],
    );
  }
}

class TheButton extends ConsumerWidget {
  const TheButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final type = config.type;
    Widget content = Text(type.contentName);
    Widget icon = const Icon(Icons.category_rounded);
    VoidCallback? onPressed;
    if (config.enabled) {
      onPressed = () {};
    }
    switch (type) {
      case ButtonType.text:
        return TextButton(onPressed: onPressed, child: content);
      case ButtonType.textIcon:
        return TextButton.icon(
            onPressed: onPressed, icon: icon, label: content);
      case ButtonType.filled:
        return FilledButton(onPressed: onPressed, child: content);
      case ButtonType.filledIcon:
        return FilledButton.icon(
            onPressed: onPressed, icon: icon, label: content);
      case ButtonType.filledTonal:
        return FilledButton.tonal(onPressed: onPressed, child: content);
      case ButtonType.filledTonalIcon:
        return FilledButton.tonalIcon(
          onPressed: onPressed,
          icon: icon,
          label: content,
        );
      case ButtonType.elevated:
        return ElevatedButton(onPressed: onPressed, child: content);
      case ButtonType.elevatedIcon:
        return ElevatedButton.icon(
            onPressed: onPressed, icon: icon, label: content);

      case ButtonType.outlined:
        return OutlinedButton(onPressed: onPressed, child: content);
      case ButtonType.outlinedIcon:
        return OutlinedButton.icon(
            onPressed: onPressed, icon: icon, label: content);
      case ButtonType.icon:
        return IconButton(onPressed: onPressed, icon: icon);
      case ButtonType.iconFilled:
        return IconButton.filled(onPressed: onPressed, icon: icon);
      case ButtonType.iconFilledTonal:
        return IconButton.filledTonal(onPressed: onPressed, icon: icon);
      case ButtonType.iconOutlined:
        return IconButton.outlined(onPressed: onPressed, icon: icon);
    }
  }
}
