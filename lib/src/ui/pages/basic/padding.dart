// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:dreambook/src/codes/painting/edge_insets.dart';
import 'package:dreambook/src/codes/widgets/stateful_widget.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_area.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'padding.g.dart';

final paddingItem = CodeItem(
  title: (context) => context.tr.padding,
  code: const TheCode(),
  widget: const TheWidget(),
);

class PaddingConfig {
  PaddingConfig({
    this.top = 0,
    this.left = 0,
    this.right = 0,
    this.bottom = 0,
  });
  final double top;
  final double left;
  final double right;
  final double bottom;

  PaddingConfig copyWith({
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return PaddingConfig(
      top: top ?? this.top,
      left: left ?? this.left,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  PaddingConfig build() => PaddingConfig();
  void change(PaddingConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return CodeArea(
      api: '/flutter/widgets/Padding-class.html',
      codes: [
        StatefulWidgetX(
          buildReturn: EdgeInsets.only(
            top: config.top,
            left: config.left,
            right: config.right,
            bottom: config.bottom,
          ).$exp,
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
      content: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: config.top,
            left: config.left,
            right: config.right,
            bottom: config.bottom,
          ),
          child: Container(color: Colors.green[800]),
        ),
      ),
      configs: [
        SlidableTile(
          title: 'Top',
          value: config.top,
          max: 64,
          divisions: 16,
          onChanged: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(top: t));
          },
        ),
        SlidableTile(
          title: 'Left',
          value: config.left,
          max: 64,
          divisions: 16,
          onChanged: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(left: t));
          },
        ),
        SlidableTile(
          title: 'Right',
          value: config.right,
          max: 64,
          divisions: 16,
          onChanged: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(right: t));
          },
        ),
        SlidableTile(
          title: 'Bottom',
          value: config.bottom,
          max: 64,
          divisions: 16,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(bottom: t));
          },
        ),
      ],
    );
  }
}
