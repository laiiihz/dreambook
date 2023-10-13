// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_span.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'checkbox.g.dart';

final checkboxItem = CodeItem(
  title: 'Checkbox',
  code: const TheCode(),
  widget: const TheWidget(),
);

class CheckboxConfig {
  CheckboxConfig({this.tristate = false});
  final bool tristate;

  CheckboxConfig copyWith({
    bool? tristate,
  }) {
    return CheckboxConfig(
      tristate: tristate ?? this.tristate,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  CheckboxConfig build() => CheckboxConfig();
  void change(CheckboxConfig config) {
    state = config;
  }
}

@riverpod
class TheState extends _$TheState {
  @override
  bool? build() => false;
  void change(bool? value) {
    state = value;
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
      'bool? state = false;',
      '',
      'Checkbox(',
      if (config.tristate) '  tristate: config.tristate,',
      '  value: state,',
      '  onChanged: (t) => SetState(() => state = t),',
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
      content: Checkbox(
        tristate: config.tristate,
        value: ref.watch(theStateProvider),
        onChanged: (state) {
          ref.read(theStateProvider.notifier).change(state);
        },
      ),
      configs: [
        SwitchListTile(
          title: const Text('tristate'),
          value: config.tristate,
          onChanged: (t) {
            if (!t) {
              ref.read(theStateProvider.notifier).change(false);
            }
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(tristate: t));
          },
        ),
      ],
    );
  }
}
