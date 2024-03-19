// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/painting/edge_insets.dart';
import 'package:dreambook/src/codes/painting/flutter_logo.dart';
import 'package:dreambook/src/codes/widgets/text.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_gen.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_view.g.dart';

final listViewItem = CodeItem(
  title: (context) => 'ListView',
  code: const TheCode(),
  widget: const TheWidget(),
);

enum ListViewType {
  children,
  builder,
  seperated,
}

class ListViewConfig {
  ListViewConfig({
    this.type = ListViewType.children,
    this.showItemCount = false,
    this.itemCount = 6,
    this.padding = 16,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
  });

  final ListViewType type;
  final bool showItemCount;
  final int itemCount;
  final int padding;
  final bool reverse;
  final Axis scrollDirection;

  EdgeInsets get paddingValue => EdgeInsets.all(padding + .0);

  ListViewConfig copyWith({
    ListViewType? type,
    bool? showItemCount,
    int? itemCount,
    int? padding,
    bool? reverse,
    Axis? scrollDirection,
  }) {
    return ListViewConfig(
      type: type ?? this.type,
      showItemCount: showItemCount ?? this.showItemCount,
      itemCount: itemCount ?? this.itemCount,
      padding: padding ?? this.padding,
      reverse: reverse ?? this.reverse,
      scrollDirection: scrollDirection ?? this.scrollDirection,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  ListViewConfig build() => ListViewConfig();
  void change(ListViewConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final itemBuilderMethod = CodeGen.indexedBuilder(
      lambda: true,
      body: CodeGen.outlinedButton(
        child: refer('index').toStringCode,
        onPressed: CodeGen.voidCallback,
      ).code,
    );

    return AutoCode(
      switch (config.type) {
        ListViewType.children => 'ListView',
        ListViewType.builder => 'ListView.builder',
        ListViewType.seperated => 'ListView.seperated',
      },
      named: {
        if (config.reverse) 'reverse': literalBool(true),
        if (config.scrollDirection case Axis.horizontal)
          'scrollDirection': config.scrollDirection.toCode,
        if (config.padding != 0) 'padding': config.paddingValue.$exp,
        ...switch (config.type) {
          ListViewType.children => {
              'children': literalList(List.generate(6, (index) {
                return CodeGen.outlinedButton(
                  child: TextX(refer('$index')),
                  onPressed: CodeGen.voidCallback,
                );
              })),
            },
          ListViewType.builder => {
              'itemBuilder': itemBuilderMethod,
              if (config.showItemCount)
                'itemCount': literalNum(config.itemCount),
            },
          ListViewType.seperated => {
              'itemBuilder': itemBuilderMethod,
              'separatorBuilder': CodeGen.indexedBuilder(
                lambda: true,
                body: FlutterLogoX().code,
              ),
              'itemCount': literalNum(config.itemCount),
            },
        }
      },
      apiUrl: '/flutter/widgets/ListView-class.html',
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    Widget itemBuilder(int index) {
      return OutlinedButton(onPressed: () {}, child: Text(index.toString()));
    }

    final items = List.generate(6, itemBuilder);

    return WidgetWithConfiguration(
      initialFractions: const [0.5, 0.5],
      content: switch (config.type) {
        ListViewType.children => ListView(
            scrollDirection: config.scrollDirection,
            reverse: config.reverse,
            padding: EdgeInsets.all(config.padding + .0),
            children: items,
          ),
        ListViewType.builder => ListView.builder(
            scrollDirection: config.scrollDirection,
            reverse: config.reverse,
            padding: EdgeInsets.all(config.padding + .0),
            itemBuilder: (context, index) => itemBuilder(index),
            itemCount: config.showItemCount ? config.itemCount : null,
          ),
        ListViewType.seperated => ListView.separated(
            scrollDirection: config.scrollDirection,
            reverse: config.reverse,
            padding: EdgeInsets.all(config.padding + .0),
            itemBuilder: (context, index) => itemBuilder(index),
            separatorBuilder: (context, index) => const FlutterLogo(),
            itemCount: config.itemCount,
          ),
      },
      configs: [
        MenuTile(
          title: context.tr.theType,
          items: ListViewType.values,
          current: config.type,
          onTap: (e) {
            ref.read(configProvider.notifier).change(config.copyWith(type: e));
          },
          contentBuilder: (e) => e.name,
        ),
        MenuTile(
          title: 'Scroll Direction',
          items: Axis.values,
          current: config.scrollDirection,
          onTap: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(scrollDirection: e));
          },
          contentBuilder: (e) => e.name,
        ),
        SwitchListTile(
          title: const Text('Reverse'),
          value: config.reverse,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(reverse: t));
          },
        ),
        if (config.type == ListViewType.builder)
          SwitchListTile(
            title: const Text('show item count'),
            value: config.showItemCount,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(showItemCount: t));
            },
          ),
        if ((config.type == ListViewType.builder && config.showItemCount) ||
            config.type == ListViewType.seperated)
          SlidableTile(
            title: 'count',
            value: config.itemCount.toDouble(),
            max: 32,
            min: 1,
            divisions: 32,
            onChanged: (e) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(itemCount: e.toInt()));
            },
          ),
        SlidableTile(
          title: context.tr.padding,
          value: config.padding.toDouble(),
          max: 64,
          min: 0,
          divisions: 8,
          onChanged: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(padding: e.toInt()));
          },
        ),
      ],
    );
  }
}
