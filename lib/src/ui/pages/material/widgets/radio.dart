// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_span.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'radio.g.dart';

final radioItem = CodeItem(
  title: 'Radio',
  code: const TheCode(),
  widget: const TheWidget(),
);

class RadioConfig {
  RadioConfig({this.toggleable = false});

  final bool toggleable;

  RadioConfig copyWith({
    bool? toggleable,
  }) {
    return RadioConfig(
      toggleable: toggleable ?? this.toggleable,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  RadioConfig build() => RadioConfig();
  void change(RadioConfig config) {
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
      '''ListView(
  children: List.generate(
    3,
    (index) => ListTile(
      leading: Radio<int>(${config.toggleable ? '\n        toggleable: true,' : ''}
        value: index,
        groupValue: ref.watch(currentItemProvider),
        onChanged: (t) {
          ref.read(currentItemProvider.notifier).change(t);
        },
      ),
      title: Text('Item \$index'),
    ),
  ),
)''',
    ]);
  }
}

@riverpod
class CurrentItem extends _$CurrentItem {
  @override
  int? build() => null;

  void change(int? config) {
    state = config;
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: ListView(
        children: List.generate(
          3,
          (index) => ListTile(
            leading: Radio<int>(
              toggleable: true,
              value: index,
              groupValue: ref.watch(currentItemProvider),
              onChanged: (t) {
                ref.read(currentItemProvider.notifier).change(t);
              },
            ),
            title: Text('Item $index'),
          ),
        ),
      ),
      configs: [
        SwitchListTile(
            title: const Text('Toggleable'),
            value: config.toggleable,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(toggleable: t));
            }),
      ],
    );
  }
}
