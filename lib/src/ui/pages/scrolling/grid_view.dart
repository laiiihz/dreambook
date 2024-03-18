// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/painting/edge_insets.dart';
import 'package:dreambook/src/codes/painting/flutter_logo.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_gen.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'grid_view.g.dart';

final gridViewItem = CodeItem(
  title: (context) => 'GridView',
  code: const TheCode(),
  widget: const TheWidget(),
);

enum GridViewType {
  children,
  count,
  builder,
  extend,
}

enum GridDelegateType {
  max,
  fixed,
}

class GridViewConfig {
  GridViewConfig({
    this.type = GridViewType.children,
    this.padding = 0,
    this.crossAxisCount = 4,
    this.maxCrossAxisExtent = 160,
    this.delegate = GridDelegateType.fixed,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.childAspectRatio = 1,
    this.itemCount = 6,
    this.reverse = false,
  });

  final GridViewType type;
  final int padding;

  final int crossAxisCount;
  final int maxCrossAxisExtent;
  final GridDelegateType delegate;
  final int mainAxisSpacing;
  final int crossAxisSpacing;
  final double childAspectRatio;
  final int itemCount;
  final bool reverse;

  EdgeInsets get paddingValue => EdgeInsets.all(padding + .0);

  GridViewConfig copyWith({
    GridViewType? type,
    int? padding,
    int? crossAxisCount,
    int? maxCrossAxisExtent,
    GridDelegateType? delegate,
    int? mainAxisSpacing,
    int? crossAxisSpacing,
    double? childAspectRatio,
    int? itemCount,
    bool? reverse,
  }) {
    return GridViewConfig(
      type: type ?? this.type,
      padding: padding ?? this.padding,
      crossAxisCount: crossAxisCount ?? this.crossAxisCount,
      maxCrossAxisExtent: maxCrossAxisExtent ?? this.maxCrossAxisExtent,
      delegate: delegate ?? this.delegate,
      mainAxisSpacing: mainAxisSpacing ?? this.mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing ?? this.crossAxisSpacing,
      childAspectRatio: childAspectRatio ?? this.childAspectRatio,
      itemCount: itemCount ?? this.itemCount,
      reverse: reverse ?? this.reverse,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  GridViewConfig build() => GridViewConfig();
  void change(GridViewConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final children = literalList(List.generate(
      config.itemCount,
      (index) => CodeGen.outlinedButton(
        child: FlutterLogoX(),
        onPressed: CodeGen.voidCallback,
      ),
    ));
    final gridDelegate = switch (config.delegate) {
      GridDelegateType.max => InvokeExpression.newOf(
          refer('SliverGridDelegateWithMaxCrossAxisExtent'),
          [],
          {
            'maxCrossAxisExtent': literalNum(config.maxCrossAxisExtent),
            'mainAxisSpacing': literalNum(config.mainAxisSpacing),
            'crossAxisSpacing': literalNum(config.crossAxisSpacing),
            'childAspectRatio': literalNum(config.childAspectRatio),
          },
        ),
      GridDelegateType.fixed => InvokeExpression.newOf(
          refer('SliverGridDelegateWithFixedCrossAxisCount'),
          [],
          {
            'crossAxisCount': literalNum(config.crossAxisCount),
            'mainAxisSpacing': literalNum(config.mainAxisSpacing),
            'crossAxisSpacing': literalNum(config.crossAxisSpacing),
            'childAspectRatio': literalNum(config.childAspectRatio),
          },
        ),
    };
    return AutoCode(
      switch (config.type) {
        GridViewType.children => 'GridView',
        GridViewType.count => 'GridView.count',
        GridViewType.builder => 'GridView.builder',
        GridViewType.extend => 'GridView.extend',
      },
      named: {
        if (config.padding != 0) 'padding': config.paddingValue.$exp,
        if (config.reverse) 'reverse': literalBool(true),
        ...switch (config.type) {
          GridViewType.children => {
              'gridDelegate': gridDelegate,
              'children': children,
            },
          GridViewType.count => {
              'children': children,
              'crossAxisCount': literalNum(config.crossAxisCount),
              'mainAxisSpacing': literalNum(config.mainAxisSpacing),
              'crossAxisSpacing': literalNum(config.crossAxisSpacing),
              'childAspectRatio': literalNum(config.childAspectRatio),
            },
          GridViewType.extend => {
              'children': children,
              'maxCrossAxisExtent': literalNum(config.maxCrossAxisExtent),
              'mainAxisSpacing': literalNum(config.mainAxisSpacing),
              'crossAxisSpacing': literalNum(config.crossAxisSpacing),
              'childAspectRatio': literalNum(config.childAspectRatio),
            },
          GridViewType.builder => {
              'gridDelegate': gridDelegate,
              'itemBuilder': CodeGen.indexedBuilder(
                lambda: true,
                body: CodeGen.outlinedButton(
                  child: FlutterLogoX(),
                  onPressed: CodeGen.voidCallback,
                ).code,
              ),
            },
        },
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final gridDelegate = switch (config.delegate) {
      GridDelegateType.max => SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: config.maxCrossAxisExtent + .0,
          mainAxisSpacing: config.mainAxisSpacing + .0,
          crossAxisSpacing: config.crossAxisSpacing + .0,
          childAspectRatio: config.childAspectRatio,
        ),
      GridDelegateType.fixed => SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: config.crossAxisCount,
          mainAxisSpacing: config.mainAxisSpacing + .0,
          crossAxisSpacing: config.crossAxisSpacing + .0,
          childAspectRatio: config.childAspectRatio,
        ),
    };
    final item = OutlinedButton(
      child: const FlutterLogo(),
      onPressed: () {},
    );
    final children = List.generate(config.itemCount, (index) => item);
    final countConfig = SlidableTile(
      title: 'crossAxisCount',
      value: config.crossAxisCount + .0,
      max: 10,
      min: 2,
      divisions: 8,
      onChanged: (e) {
        ref
            .read(configProvider.notifier)
            .change(config.copyWith(crossAxisCount: e.toInt()));
      },
    );
    final extendConfig = SlidableTile(
        title: 'maxCrossAxisExtent',
        value: config.maxCrossAxisExtent + .0,
        max: 480,
        min: 80,
        divisions: 20,
        onChanged: (e) {
          ref
              .read(configProvider.notifier)
              .change(config.copyWith(maxCrossAxisExtent: e.toInt()));
        });
    return WidgetWithConfiguration(
      initialFractions: const [0.5, 0.5],
      content: switch (config.type) {
        GridViewType.children => GridView(
            gridDelegate: gridDelegate,
            padding: config.paddingValue,
            reverse: config.reverse,
            children: children,
          ),
        GridViewType.count => GridView.count(
            padding: config.paddingValue,
            reverse: config.reverse,
            crossAxisCount: config.crossAxisCount,
            mainAxisSpacing: config.mainAxisSpacing + .0,
            crossAxisSpacing: config.crossAxisSpacing + .0,
            childAspectRatio: config.childAspectRatio,
            children: children,
          ),
        GridViewType.builder => GridView.builder(
            padding: config.paddingValue,
            reverse: config.reverse,
            gridDelegate: gridDelegate,
            itemBuilder: (context, index) => item,
          ),
        GridViewType.extend => GridView.extent(
            padding: config.paddingValue,
            reverse: config.reverse,
            maxCrossAxisExtent: config.maxCrossAxisExtent + .0,
            mainAxisSpacing: config.mainAxisSpacing + .0,
            crossAxisSpacing: config.crossAxisSpacing + .0,
            childAspectRatio: config.childAspectRatio,
            children: children,
          ),
      },
      configs: [
        MenuTile(
          title: context.tr.theType,
          items: GridViewType.values,
          current: config.type,
          onTap: (e) {
            ref.read(configProvider.notifier).change(config.copyWith(type: e));
          },
          contentBuilder: (e) => e.name,
        ),
        SlidableTile(
          title: context.tr.padding,
          value: config.padding + .0,
          max: 64,
          min: 0,
          divisions: 16,
          onChanged: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(padding: e.toInt()));
          },
        ),
        SwitchListTile(
          title: const Text('Reverse'),
          value: config.reverse,
          onChanged: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(reverse: e));
          },
        ),
        switch (config.type) {
          GridViewType.count => countConfig,
          GridViewType.children ||
          GridViewType.builder when config.delegate == GridDelegateType.fixed =>
            countConfig,
          _ => null,
        },
        switch (config.type) {
          GridViewType.children ||
          GridViewType.builder when config.delegate == GridDelegateType.max =>
            extendConfig,
          GridViewType.extend => extendConfig,
          _ => null,
        },
        SlidableTile(
          title: 'Aspect Ratio',
          value: config.childAspectRatio,
          max: 4,
          min: 0.2,
          onChanged: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(childAspectRatio: e));
          },
        ),
        switch (config.type) {
          GridViewType.children || GridViewType.builder => MenuTile(
              title: 'Delegate Type',
              items: GridDelegateType.values,
              current: config.delegate,
              onTap: (e) {
                ref
                    .read(configProvider.notifier)
                    .change(config.copyWith(delegate: e));
              },
              contentBuilder: (e) => e.name,
            ),
          _ => null,
        },
        SlidableTile(
          title: 'mainAxisSpacing',
          value: config.mainAxisSpacing + .0,
          min: 0,
          max: 32,
          divisions: 16,
          onChanged: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(mainAxisSpacing: e.toInt()));
          },
        ),
        SlidableTile(
          title: 'crossAxisSpacing',
          value: config.crossAxisSpacing + .0,
          min: 0,
          max: 32,
          divisions: 16,
          onChanged: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(crossAxisSpacing: e.toInt()));
          },
        ),
        // final int itemCount;
      ],
    );
  }
}
