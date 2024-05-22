// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:dreambook/src/codes/widgets/widgets.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_area.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'opacity.g.dart';

final opacityItem = CodeItem(
  title: (context) => context.tr.opacity,
  code: const TheCode(),
  widget: const TheWidget(),
);

class OpacityConfig {
  OpacityConfig({
    this.value = 1,
  });

  final double value;

  OpacityConfig copyWith({
    double? value,
  }) {
    return OpacityConfig(
      value: value ?? this.value,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  OpacityConfig build() => OpacityConfig();
  void change(OpacityConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return CodeArea(
      api: '/flutter/widgets/Opacity-class.html',
      codes: [
        StatelessWidgetX(
          buildReturn: OpacityX(
            opacity: config.value,
            child: FlutterLogoX(size: 128),
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
      content: Opacity(
        opacity: config.value,
        child: const FlutterLogo(size: 128),
      ),
      configs: [
        SlidableTile(
          title: context.tr.value,
          value: config.value,
          divisions: 10,
          onChanged: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(value: t));
          },
        ),
      ],
    );
  }
}
