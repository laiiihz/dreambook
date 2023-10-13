// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_span.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'bottom_sheet.g.dart';

final bottomSheetItem = CodeItem(
  title: 'Bottom Sheet',
  code: const TheCode(),
  widget: const TheWidget(),
);

class BottomSheetConfig {
  final bool showDragHandle;

  BottomSheetConfig({this.showDragHandle = true});

  BottomSheetConfig copyWith({
    bool? showDragHandle,
  }) {
    return BottomSheetConfig(
      showDragHandle: showDragHandle ?? this.showDragHandle,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  BottomSheetConfig build() => BottomSheetConfig();
  void change(BottomSheetConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return CodeSpace([
      StaticCodes.material,
      '',
      'FilledButton(',
      '  onPressed: () {',
      '    showModalBottomSheet(',
      '      context: context,',
      if (config.showDragHandle) '      showDragHandle: config.showDragHandle,',
      '''      builder: (context) {
                return const SizedBox(height: 300, width: double.infinity);
      },''',
      '    );',
      '  },',
      "  child: const Text('Open Bottom Sheet'),",
      ')',
    ]);
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: FilledButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            showDragHandle: config.showDragHandle,
            builder: (context) {
              return const SizedBox(height: 300, width: double.infinity);
            },
          );
        },
        child: const Text('Open Bottom Sheet'),
      ),
      configs: [
        SwitchListTile(
            title: const Text('Show Drag Handle'),
            value: config.showDragHandle,
            onChanged: (t) {
              ref
                  .watch(configProvider.notifier)
                  .change(BottomSheetConfig(showDragHandle: t));
            })
      ],
    );
  }
}
