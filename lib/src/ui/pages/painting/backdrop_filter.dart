// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'dart:ui';

import 'package:dreambook/src/codes/widgets/widgets.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_area.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backdrop_filter.g.dart';

final backdropFilterBoxItem = CodeItem(
  title: (context) => context.tr.backdropFilter,
  code: const TheCode(),
  widget: const TheWidget(),
);

enum BackdropMode {
  erode,
  blur,
  dilate,
}

class BackdropFilterConfig {
  BackdropFilterConfig({this.mode = BackdropMode.blur});

  final BackdropMode mode;

  BackdropFilterConfig copyWith({
    BackdropMode? mode,
  }) {
    return BackdropFilterConfig(
      mode: mode ?? this.mode,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  BackdropFilterConfig build() => BackdropFilterConfig();
  void change(BackdropFilterConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return CodeArea(
      api: '/flutter/widgets/BackdropFilter-class.html',
      codes: [
        StatelessWidgetX(
          buildReturn: StackX(
            children: [
              FlutterLogoX(size: 128),
              ClipRectX(
                child: BackdropFilterX(
                  filter: switch (config.mode) {
                    BackdropMode.erode =>
                      ImageFilterX.erode(radiusX: 4, radiusY: 4),
                    BackdropMode.blur =>
                      ImageFilterX.blur(sigmaX: 12, sigmaY: 12),
                    BackdropMode.dilate =>
                      ImageFilterX.dilate(radiusX: 4, radiusY: 4),
                  },
                  child: SizedBoxX.square(dimension: 128),
                ),
              ),
            ],
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
      content: Stack(
        children: [
          const Row(
            children: [FlutterLogo(size: 128), FlutterLogo(size: 128)],
          ),
          ClipRect(
            child: BackdropFilter(
              filter: switch (config.mode) {
                BackdropMode.erode => ImageFilter.erode(radiusX: 4, radiusY: 4),
                BackdropMode.blur => ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                BackdropMode.dilate =>
                  ImageFilter.dilate(radiusX: 4, radiusY: 4),
              },
              child: const SizedBox.square(dimension: 128),
            ),
          ),
        ],
      ),
      configs: [
        MenuTile(
          title: 'Mode',
          // web platform only support blur effect
          items: kIsWeb ? [BackdropMode.blur] : BackdropMode.values,
          current: config.mode,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(mode: t));
          },
          contentBuilder: (t) => t.name,
        )
      ],
    );
  }
}
