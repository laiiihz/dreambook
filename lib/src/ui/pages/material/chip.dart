// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chip.g.dart';

final chipItem = CodeItem(
  title: (context) => context.tr.chip,
  code: const TheCode(),
  widget: const TheWidget(),
);

enum ChipType {
  normal('Chip'),
  input('InputChip'),
  choice('ChoiceChip'),
  filter('FilterChip'),
  action('ActionChip'),
  ;

  const ChipType(this.code);
  final String code;
}

class ChipConfig {
  ChipConfig({
    this.type = ChipType.normal,
    this.showAvatar = false,
    this.showDelete = false,
    this.enabled = true,
    this.selected = false,
    this.showOnSelected = false,
  });

  final ChipType type;
  final bool showAvatar;
  final bool showDelete;
  final bool enabled;
  final bool selected;
  final bool showOnSelected;

  ChipConfig copyWith({
    ChipType? type,
    bool? showAvatar,
    bool? showDelete,
    bool? enabled,
    bool? selected,
    bool? showOnSelected,
  }) {
    return ChipConfig(
      type: type ?? this.type,
      showAvatar: showAvatar ?? this.showAvatar,
      showDelete: showDelete ?? this.showDelete,
      enabled: enabled ?? this.enabled,
      selected: selected ?? this.selected,
      showOnSelected: showOnSelected ?? this.showOnSelected,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  ChipConfig build() => ChipConfig();
  void change(ChipConfig config) {
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
      named: {
        'label': refer("const Text('${config.type.name}')"),
        if (config.showAvatar) 'avatar': refer('const CircleAvatar()'),
        if (config.showDelete) 'onDeleted': refer('() {}'),
        if (config.enabled)
          ...switch (config.type) {
            ChipType.input => {'isEnabled': refer('true')},
            ChipType.action => {'onPressed': refer('() {}')},
            _ => {},
          },
        if (config.showOnSelected)
          ...switch (config.type) {
            ChipType.filter || ChipType.choice || ChipType.input => {
                'onSelected': refer('() {}')
              },
            _ => {},
          }
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
      content: const TheChip(),
      configs: [
        MenuTile(
          title: context.tr.theType,
          items: ChipType.values,
          current: config.type,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(type: t));
          },
          contentBuilder: (t) => t.name,
        ),
        if (config.type != ChipType.normal)
          SwitchListTile(
            title: Text(context.tr.enabled),
            value: config.enabled,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(enabled: t));
            },
          ),
        SwitchListTile(
          title: const Text('Show Avatar'),
          value: config.showAvatar,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showAvatar: t));
          },
        ),
        SwitchListTile(
          title: const Text('Show Delete'),
          value: config.showDelete,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showDelete: t));
          },
        ),
        if (config.type == ChipType.choice ||
            config.type == ChipType.input ||
            config.type == ChipType.filter) ...[
          SwitchListTile(
            title: const Text('Selected'),
            value: config.selected,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(selected: t));
            },
          ),
          SwitchListTile(
            title: const Text('show On Selected'),
            value: config.showOnSelected,
            onChanged: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(showOnSelected: t));
            },
          ),
        ],
      ],
    );
  }
}

class TheChip extends ConsumerWidget {
  const TheChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final label = Text(config.type.name);
    final Widget? avatar = config.showAvatar ? const CircleAvatar() : null;
    final VoidCallback? onDelete = config.showDelete ? () {} : null;
    final ValueChanged<bool>? onSelected =
        config.showOnSelected ? (t) {} : null;
    late final Widget chip;

    switch (config.type) {
      case ChipType.normal:
        chip = Chip(label: label, avatar: avatar, onDeleted: onDelete);
      case ChipType.input:
        chip = InputChip(
          label: label,
          avatar: avatar,
          onDeleted: onDelete,
          isEnabled: config.enabled,
          selected: config.selected,
          onSelected: onSelected,
        );
      case ChipType.choice:
        chip = ChoiceChip(
          label: label,
          avatar: avatar,
          selected: config.selected,
          onSelected: onSelected,
        );
      case ChipType.filter:
        chip = FilterChip(
          label: label,
          avatar: avatar,
          onSelected: onSelected,
          selected: config.selected,
        );
      case ChipType.action:
        chip = ActionChip(
          label: label,
          avatar: avatar,
          onPressed: config.enabled ? () {} : null,
        );
    }
    return chip;
  }
}
