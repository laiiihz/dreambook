// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';

part 'clip.g.dart';

final clipItem = CodeItem(
  title: (context) => context.tr.clip,
  code: const TheCode(),
  widget: const TheWidget(),
);

class ClipConfig {
  ClipConfig({
    this.type = ClipType.rect,
    this.clipBehavior = Clip.antiAlias,
  });

  final ClipType type;
  final Clip clipBehavior;

  ClipConfig copyWith({
    ClipType? type,
    Clip? clipBehavior,
  }) {
    return ClipConfig(
      type: type ?? this.type,
      clipBehavior: clipBehavior ?? this.clipBehavior,
    );
  }
}

enum ClipType {
  oval('ClipOval'),
  rect('ClipRect'),
  rrect('ClipRRect'),
  path('ClipPath'),
  ;

  const ClipType(this.code);

  final String code;
}

@riverpod
class Config extends _$Config {
  @override
  ClipConfig build() => ClipConfig();
  void change(ClipConfig config) {
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
      apiUrl: '/flutter/widgets/${config.type.code}-class.html',
      named: {
        if (config.clipBehavior != Clip.antiAlias)
          'clipBehavior': refer(config.clipBehavior.name),
        if (config.type == ClipType.rrect)
          'borderRadius': refer('BorderRadius.circular(12)'),
        if (config.type == ClipType.path)
          'clipper': refer('const ShapeBorderClipper(shape: StarBorder())'),
        'child': refer(
            'const Material(color: Colors.green, child: FlutterLogo(size: 128))'),
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    const child = Material(color: Colors.green, child: FlutterLogo(size: 128));
    return WidgetWithConfiguration(
      content: switch (config.type) {
        ClipType.oval => ClipOval(
            clipBehavior: config.clipBehavior,
            child: child,
          ),
        ClipType.rect => ClipRect(
            clipBehavior: config.clipBehavior,
            child: child,
          ),
        ClipType.rrect => ClipRRect(
            borderRadius: BorderRadius.circular(12),
            clipBehavior: config.clipBehavior,
            child: child,
          ),
        ClipType.path => ClipPath(
            clipper: const ShapeBorderClipper(shape: StarBorder()),
            clipBehavior: config.clipBehavior,
            child: child,
          ),
      },
      configs: [
        MenuTile<ClipType>(
          title: context.tr.theType,
          items: ClipType.values,
          current: config.type,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(type: t));
          },
          contentBuilder: (t) => t.name,
        ),
        MenuTile<Clip>(
          title: 'Clip Behavior',
          items: Clip.values,
          current: config.clipBehavior,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(clipBehavior: t));
          },
          contentBuilder: (t) => t.name,
        ),
      ],
    );
  }
}
