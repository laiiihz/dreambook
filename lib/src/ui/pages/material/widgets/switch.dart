// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_span.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'switch.g.dart';

final switchItem = CodeItem(
  title: 'Switch',
  code: const TheCode(),
  widget: const TheWidget(),
);

class ListTileConfig {
  ListTileConfig({this.enabled = true});
  final bool enabled;

  ListTileConfig copyWith({
    bool? enabled,
  }) {
    return ListTileConfig(
      enabled: enabled ?? this.enabled,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  ListTileConfig build() => ListTileConfig();

  void change(ListTileConfig config) {
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
      'bool state = false;',
      'Switch(',
      '  value: state,',
      if (!config.enabled)
        'onChanged: null,'
      else
        '''  onChanged: (value) {
    setState(() {
      state = value;
    });
  },''',
      ')',
    ]);
  }
}

@riverpod
class SwitchState extends _$SwitchState {
  @override
  bool build() => false;

  void change(bool value) {
    state = value;
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: Switch(
        value: ref.watch(switchStateProvider),
        onChanged: config.enabled
            ? (value) {
                ref.read(switchStateProvider.notifier).change(value);
              }
            : null,
      ),
      configs: [
        SwitchListTile(
          title: const Text('Enabled'),
          value: config.enabled,
          onChanged: (value) {
            ref
                .watch(configProvider.notifier)
                .change(config.copyWith(enabled: value));
          },
        )
      ],
    );
  }
}
