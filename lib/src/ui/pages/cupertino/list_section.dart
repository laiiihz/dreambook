// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'list_section.g.dart';

final listSectionItem = CodeItem(
  title: 'List Section',
  code: const TheCode(),
  widget: const TheWidget(),
);

class ListSectionConfig {
  ListSectionConfig({
    this.hasChildren = true,
    this.hasFooter = false,
  });

  final bool hasChildren;
  final bool hasFooter;

  ListSectionConfig copyWith({
    bool? hasChildren,
    bool? hasFooter,
  }) {
    return ListSectionConfig(
      hasChildren: hasChildren ?? this.hasChildren,
      hasFooter: hasFooter ?? this.hasFooter,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  ListSectionConfig build() => ListSectionConfig();

  void change(ListSectionConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'ListSection',
      named: {
        'header': refer("const Text('Header')"),
        if (config.hasChildren)
          'children': literalList([
            InvokeExpression.newOf(
              refer('CupertinoListTile'),
              [],
              {
                'leading': refer('Icon(CupertinoIcons.settings)'),
                'title': refer('Text(\'Tile Item A\')'),
              },
            ),
            InvokeExpression.newOf(
              refer('CupertinoListTile'),
              [],
              {
                'leading': refer('Icon(CupertinoIcons.airplane)'),
                'title': refer('Text(\'Tile Item B\')'),
              },
            ),
          ]),
        if (config.hasFooter) 'footer': refer("const Text('Footer')"),
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
      content: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        child: SingleChildScrollView(
          child: CupertinoListSection(
            header: const Text('Header'),
            footer: config.hasFooter ? const Text('Footer') : null,
            children: config.hasChildren
                ? const [
                    CupertinoListTile(
                      leading: Icon(CupertinoIcons.settings),
                      title: Text('Tile Item A'),
                    ),
                    CupertinoListTile(
                      leading: Icon(CupertinoIcons.airplane),
                      title: Text('Tile Item B'),
                    ),
                  ]
                : null,
          ),
        ),
      ),
      configs: [
        SwitchListTile(
          title: const Text('Has Children'),
          value: config.hasChildren,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(hasChildren: t));
          },
        ),
        SwitchListTile(
          title: const Text('Has Footer'),
          value: config.hasFooter,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(hasFooter: t));
          },
        ),
      ],
    );
  }
}
