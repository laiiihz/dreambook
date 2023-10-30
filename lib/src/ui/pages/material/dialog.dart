// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dialog.g.dart';

final dialogItem = CodeItem(
  title: (context) => context.tr.dialog,
  code: const TheCode(),
  widget: const TheWidget(),
);

enum DialogType {
  alert('AlertDialog'),
  simple('SimpleDialog'),
  ;

  const DialogType(this.code);
  final String code;
}

class DialogConfig {
  DialogConfig({
    this.type = DialogType.simple,
    this.hasTitle = true,
    this.hasActions = false,
    this.hasContent = false,
    this.hasIcon = false,
    this.hasChildren = true,
  });

  final DialogType type;
  final bool hasTitle;
  final bool hasContent;
  final bool hasActions;
  final bool hasIcon;
  final bool hasChildren;

  bool get isSimple => type == DialogType.simple;
  bool get isAlert => type == DialogType.alert;

  DialogConfig copyWith({
    DialogType? type,
    bool? hasTitle,
    bool? hasContent,
    bool? hasActions,
    bool? hasIcon,
    bool? hasChildren,
  }) {
    return DialogConfig(
      type: type ?? this.type,
      hasTitle: hasTitle ?? this.hasTitle,
      hasContent: hasContent ?? this.hasContent,
      hasActions: hasActions ?? this.hasActions,
      hasIcon: hasIcon ?? this.hasIcon,
      hasChildren: hasChildren ?? this.hasChildren,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  DialogConfig build() => DialogConfig();
  void change(DialogConfig config) {
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
      prefix: [
        //  showDialog<T>(
        //   context: context,
        //   builder: (context) => SomeWidget());
        if (ref.watch(showFullContentProvider))
          Method((f) => f
            ..name = 'showSomeDialog'
            ..modifier = MethodModifier.async
            ..returns = refer('Future<T?>')
            ..types.add(refer('T'))
            ..body = Block((b) {
              b.addExpression(InvokeExpression.newOf(
                refer('showDialog<T>'),
                [],
                {
                  'context': refer('context'),
                  'builder': Method(
                    (m) => m
                      ..requiredParameters
                          .add(Parameter((p) => p..name = 'context'))
                      ..lambda = true
                      ..body =
                          InvokeExpression.newOf(refer('SomeWidget'), []).code,
                  ).closure,
                },
              ).awaited.returned);
            })),
      ],
      named: {
        if (config.hasTitle) 'title': refer("const Text('Title')"),
        if (config.isAlert) ...{
          if (config.hasIcon) 'icon': refer("const Icon(Icons.account_circle)"),
          if (config.hasContent) 'content': refer("const Text('Content')"),
          if (config.hasActions) ...{
            'actions': literalList([
              refer(
                  "TextButton(onPressed: () {}, child: const Text('${context.mtr.cancelButtonLabel}'))"),
              refer(
                  "TextButton(onPressed: () {}, child: const Text('${context.mtr.okButtonLabel}'))"),
            ]),
          }
        } else if (config.hasChildren) ...{
          'children': refer("const Center(child: Text('children'))"),
        }
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    Widget? title = config.hasTitle ? const Text('Title') : null;
    return WidgetWithConfiguration(
      initialFractions: const [0.5, 0.5],
      content: SingleChildScrollView(
        child: switch (config.type) {
          DialogType.alert => AlertDialog(
              title: title,
              content: config.hasContent ? const Text('Content') : null,
              actions: config.hasActions
                  ? [
                      TextButton(
                          onPressed: () {},
                          child: Text(context.mtr.cancelButtonLabel)),
                      TextButton(
                          onPressed: () {},
                          child: Text(context.mtr.okButtonLabel)),
                    ]
                  : null,
              icon: config.hasIcon ? const Icon(Icons.account_circle) : null,
            ),
          DialogType.simple => SimpleDialog(
              title: title,
              children: config.hasChildren
                  ? const [Center(child: Text('children'))]
                  : null,
              // content: Text('Content'),
              // actions: [],
              // icon: Icon(Icons.account_circle),
            ),
        },
      ),
      configs: [
        MenuTile<DialogType>(
          title: 'type',
          items: DialogType.values,
          current: config.type,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(type: t));
          },
          contentBuilder: (t) => t.name,
        ),
        SwitchListTile(
          title: const Text('show Title'),
          value: config.hasTitle,
          onChanged: (value) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(hasTitle: value));
          },
        ),
        if (config.isAlert)
          SwitchListTile(
            title: const Text('show Content'),
            value: config.hasContent,
            onChanged: (value) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(hasContent: value));
            },
          ),
        if (config.isAlert)
          SwitchListTile(
            title: const Text('show Icon'),
            value: config.hasIcon,
            onChanged: (value) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(hasIcon: value));
            },
          ),
        if (config.isAlert)
          SwitchListTile(
            title: const Text('show Actions'),
            value: config.hasActions,
            onChanged: (value) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(hasActions: value));
            },
          ),
        if (config.isSimple)
          SwitchListTile(
            title: const Text('show Children'),
            value: config.hasChildren,
            onChanged: (value) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(hasChildren: value));
            },
          ),
      ],
    );
  }
}
