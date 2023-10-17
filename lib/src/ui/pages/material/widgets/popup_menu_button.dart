// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_span.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'popup_menu_button.g.dart';

final popupMenuButtonItem = CodeItem(
  title: 'Popup Menu Button',
  code: const TheCode(),
  widget: const TheWidget(),
);

class PopupMenuButtonConfig {
  PopupMenuButtonConfig({this.hasInitial = false});

  final bool hasInitial;

  PopupMenuButtonConfig copyWith({
    bool? hasInitial,
  }) {
    return PopupMenuButtonConfig(
      hasInitial: hasInitial ?? this.hasInitial,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  PopupMenuButtonConfig build() => PopupMenuButtonConfig();
  void change(PopupMenuButtonConfig config) {
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
      'int currentItem = 0;',
      '',
      'PopupMenuButton<int>(',
      if (config.hasInitial) '  initialValue: currentItem,',
      '''  itemBuilder: (context) {
    return List.generate(
      4,
      (index) => PopupMenuItem(value: index, child: Text('item \$index')),
    );
  },''',
      ')',
    ]);
  }
}

@riverpod
class InitValue extends _$InitValue {
  @override
  int? build() => null;

  void change(int value) {
    state = value;
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: PopupMenuButton<int>(
        initialValue: config.hasInitial ? ref.watch(initValueProvider) : null,
        itemBuilder: (context) {
          return List.generate(
            4,
            (index) => PopupMenuItem(value: index, child: Text('item $index')),
          );
        },
        onSelected: (value) {
          ref.read(initValueProvider.notifier).change(value);
        },
      ),
      configs: [
        SwitchListTile(
          title: const Text('has initial value'),
          value: config.hasInitial,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(hasInitial: t));
          },
        ),
      ],
    );
  }
}
