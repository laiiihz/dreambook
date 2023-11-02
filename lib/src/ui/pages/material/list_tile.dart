// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_tile.g.dart';

final listTileItem = CodeItem(
  title: (context) => context.tr.listTile,
  code: const TheCode(),
  widget: const TheWidget(),
);

class ListTileConfig {
  ListTileConfig({
    this.hasTitle = true,
    this.hasSubtitle = false,
    this.isThreeLine = false,
    this.selected = false,
    this.enabled = true,
    this.canTap = false,
    this.hasLeading = false,
    this.hasTrailing = false,
  });
  final bool hasTitle;
  final bool hasSubtitle;
  final bool isThreeLine;
  final bool selected;
  final bool enabled;
  final bool canTap;
  final bool hasLeading;
  final bool hasTrailing;

  ListTileConfig copyWith({
    bool? hasTitle,
    bool? hasSubtitle,
    bool? isThreeLine,
    bool? selected,
    bool? enabled,
    bool? canTap,
    bool? hasLeading,
    bool? hasTrailing,
  }) {
    return ListTileConfig(
      hasTitle: hasTitle ?? this.hasTitle,
      hasSubtitle: hasSubtitle ?? this.hasSubtitle,
      isThreeLine: isThreeLine ?? this.isThreeLine,
      selected: selected ?? this.selected,
      enabled: enabled ?? this.enabled,
      canTap: canTap ?? this.canTap,
      hasLeading: hasLeading ?? this.hasLeading,
      hasTrailing: hasTrailing ?? this.hasTrailing,
    );
  }
}

@riverpod
class TileConfig extends _$TileConfig {
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
    final config = ref.watch(tileConfigProvider);
    return AutoCode(
      'ListTile',
      apiUrl: '/flutter/material/ListTile-class.html',
      named: {
        if (config.hasTitle) 'title': refer("const Text('title')"),
        if (config.hasSubtitle)
          if (config.isThreeLine)
            'subtitle': refer("const Text('subtitle\\nthird line')")
          else
            'subtitle': refer("const Text('subtitle')"),
        if (config.selected) 'selected': refer('true'),
        if (!config.enabled) 'enabled': refer('false'),
        if (config.canTap) 'onTap': refer('() {}'),
        if (config.hasLeading) 'leading': refer('Icon(Icons.tag_faces)'),
        if (config.hasTrailing) 'trailing': refer('Icon(Icons.arrow_forward)'),
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(tileConfigProvider);
    return WidgetWithConfiguration(
      content: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        child: ListTile(
          enabled: config.enabled,
          title: config.hasTitle ? const Text('title') : null,
          subtitle: config.hasSubtitle
              ? Text([
                  'subtitle',
                  if (config.isThreeLine) 'three line',
                ].join('\n'))
              : null,
          isThreeLine: config.isThreeLine,
          selected: config.selected,
          trailing: config.hasTrailing ? const Icon(Icons.arrow_forward) : null,
          leading: config.hasLeading ? const Icon(Icons.tag_faces) : null,
          onTap: config.canTap ? () {} : null,
        ),
      ),
      configs: [
        SwitchListTile(
          title: const Text('title'),
          value: config.hasTitle,
          onChanged: (value) {
            ref
                .read(tileConfigProvider.notifier)
                .change(config.copyWith(hasTitle: value));
          },
        ),
        SwitchListTile(
          title: const Text('subtitle'),
          value: config.hasSubtitle,
          onChanged: (value) {
            ref.read(tileConfigProvider.notifier).change(config.copyWith(
                  hasSubtitle: value,
                  isThreeLine: value ? null : false,
                ));
          },
        ),
        if (config.hasSubtitle)
          SwitchListTile(
            title: const Text('isThreeLine'),
            value: config.isThreeLine,
            onChanged: (value) {
              ref
                  .read(tileConfigProvider.notifier)
                  .change(config.copyWith(isThreeLine: value));
            },
          ),
        SwitchListTile(
          title: const Text('selected'),
          value: config.selected,
          onChanged: (value) {
            ref
                .read(tileConfigProvider.notifier)
                .change(config.copyWith(selected: value));
          },
        ),
        SwitchListTile(
          title: Text(context.tr.enabled),
          value: config.enabled,
          onChanged: (value) {
            ref
                .read(tileConfigProvider.notifier)
                .change(config.copyWith(enabled: value));
          },
        ),
        SwitchListTile(
          title: const Text('Show Leading'),
          value: config.hasLeading,
          onChanged: (value) {
            ref
                .read(tileConfigProvider.notifier)
                .change(config.copyWith(hasLeading: value));
          },
        ),
        SwitchListTile(
          title: const Text('Show Trailing'),
          value: config.hasTrailing,
          onChanged: (value) {
            ref
                .read(tileConfigProvider.notifier)
                .change(config.copyWith(hasTrailing: value));
          },
        ),
        SwitchListTile(
          title: const Text('Can Tap'),
          value: config.canTap,
          onChanged: (value) {
            ref
                .read(tileConfigProvider.notifier)
                .change(config.copyWith(canTap: value));
          },
        ),
      ],
    );
  }
}
