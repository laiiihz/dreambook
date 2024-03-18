// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/codes/painting/alignment.dart';
import 'package:dreambook/src/codes/painting/flutter_logo.dart';
import 'package:dreambook/src/codes/widgets/container.dart';
import 'package:dreambook/src/codes/widgets/stateful_widget.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_area.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';

part 'container.g.dart';

final containerItem = CodeItem(
  title: (context) => context.tr.container,
  code: const TheCode(),
  widget: const TheWidget(),
);

class ContainerConfig {
  ContainerConfig({
    this.width = 120,
    this.height = 120,
    this.alignment,
    this.padding = 0,
  });

  final double width;
  final double height;
  final Alignment? alignment;
  final double padding;

  ContainerConfig copyWith({
    double? width,
    double? height,
    Alignment? alignment,
    double? padding,
  }) {
    return ContainerConfig(
      width: width ?? this.width,
      height: height ?? this.height,
      alignment: alignment ?? this.alignment,
      padding: padding ?? this.padding,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  ContainerConfig build() => ContainerConfig();

  void change(ContainerConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return CodeArea(
      api: '/flutter/widgets/Container-class.html',
      codes: [
        StatefulWidgetX(
          buildReturn: ContainerX(
            width: config.width,
            height: config.height,
            color$: refer('Colors').property('grey').index(literalNum(800)),
            alignment: config.alignment,
            padding:
                config.padding == 0.0 ? null : EdgeInsets.all(config.padding),
            child: FlutterLogoX(size: 48),
          ),
        ),
      ],
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
      content: Center(
        child: Container(
          padding: EdgeInsets.all(config.padding),
          color: Colors.grey[800],
          height: config.height,
          width: config.width,
          alignment: config.alignment,
          child: const FlutterLogo(size: 48),
        ),
      ),
      configs: [
        SlidableTile(
          title: 'Width',
          value: config.width,
          min: 4,
          max: 324,
          divisions: 80,
          onChanged: (e) {
            ref.read(configProvider.notifier).change(config.copyWith(width: e));
          },
        ),
        SlidableTile(
          title: 'Height',
          value: config.height,
          min: 4,
          max: 324,
          divisions: 80,
          onChanged: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(height: e));
          },
        ),
        MenuTile(
          title: context.tr.alignment,
          items: const [
            Alignment.topLeft,
            Alignment.topCenter,
            Alignment.topRight,
            Alignment.centerLeft,
            Alignment.center,
            Alignment.centerRight,
            Alignment.bottomLeft,
            Alignment.bottomCenter,
            Alignment.bottomRight,
          ],
          current: config.alignment,
          onTap: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(alignment: e));
          },
          contentBuilder: (e) => e?.name ?? 'unset',
        ),
        SlidableTile(
          title: 'Padding',
          value: config.padding,
          min: 0,
          max: 40,
          divisions: 10,
          onChanged: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(padding: e));
          },
        ),
      ],
    );
  }
}
