// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:dreambook/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flutter_logo.g.dart';

final flutterLogoItem = CodeItem(
  title: (context) => 'Flutter Logo',
  code: const TheCode(),
  widget: const TheWidget(),
);

class FlutterLogoConfig {
  FlutterLogoConfig({
    this.size = 32,
    this.style = FlutterLogoStyle.markOnly,
  });

  final double size;
  final FlutterLogoStyle style;

  FlutterLogoConfig copyWith({
    double? size,
    FlutterLogoStyle? style,
  }) {
    return FlutterLogoConfig(
      size: size ?? this.size,
      style: style ?? this.style,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  FlutterLogoConfig build() => FlutterLogoConfig();
  void change(FlutterLogoConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final size = config.size.readableStr(0);

    return AutoCode(
      'FlutterLogo',
      named: {
        'size': refer(size),
        'style': refer('FlutterLogoStyle.${config.style.name}'),
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
      content: FlutterLogo(
        size: config.size,
        style: config.style,
      ),
      configs: [
        SlidableTile(
          title: 'size',
          min: 24,
          max: 128,
          value: config.size,
          onChanged: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(size: t));
          },
        ),
        MenuTile(
          title: 'style',
          items: FlutterLogoStyle.values,
          current: config.style,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(style: t));
          },
          contentBuilder: (t) => t.name,
        ),
      ],
    );
  }
}
