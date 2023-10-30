// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'list_tile.g.dart';

final listTileItem = CodeItem(
  title: (context) => context.tr.listTile,
  code: const TheCode(),
  widget: const TheWidget(),
);

class ListTileConfig {
  ListTileConfig({
    this.hasSubtitle = false,
    this.enabled = true,
    this.canTap = false,
    this.hasLeading = false,
    this.hasTrailing = false,
    this.hasAdditionalInfo = false,
  });
  final bool hasSubtitle;
  final bool enabled;
  final bool canTap;
  final bool hasLeading;
  final bool hasTrailing;
  final bool hasAdditionalInfo;

  ListTileConfig copyWith({
    bool? hasSubtitle,
    bool? enabled,
    bool? canTap,
    bool? hasLeading,
    bool? hasTrailing,
    bool? hasAdditionalInfo,
  }) {
    return ListTileConfig(
      hasSubtitle: hasSubtitle ?? this.hasSubtitle,
      enabled: enabled ?? this.enabled,
      canTap: canTap ?? this.canTap,
      hasLeading: hasLeading ?? this.hasLeading,
      hasTrailing: hasTrailing ?? this.hasTrailing,
      hasAdditionalInfo: hasAdditionalInfo ?? this.hasAdditionalInfo,
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
      named: {
        'title': refer("const Text('title')"),
        if (config.hasSubtitle) 'subtitle': refer("const Text('subtitle')"),
        if (config.hasAdditionalInfo)
          'additionalInfo': refer("const Text('additionalInfo')"),
        if (config.canTap) 'onTap': refer('() {}'),
        if (config.hasLeading) 'leading': refer('Icon(Icons.settings)'),
        if (config.hasTrailing)
          'trailing': refer('Icon(Icons.chevron_forward)'),
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
        child: IntrinsicHeight(
          child: CupertinoListTile(
            title: const Text('title'),
            subtitle: config.hasSubtitle ? const Text('subtitle') : null,
            additionalInfo:
                config.hasAdditionalInfo ? const Text('additionalInfo') : null,
            trailing: config.hasTrailing
                ? const Icon(CupertinoIcons.chevron_forward)
                : null,
            leading:
                config.hasLeading ? const Icon(CupertinoIcons.settings) : null,
            onTap: config.canTap ? () {} : null,
          ),
        ),
      ),
      configs: [
        SwitchListTile(
          title: const Text('subtitle'),
          value: config.hasSubtitle,
          onChanged: (value) {
            ref
                .read(tileConfigProvider.notifier)
                .change(config.copyWith(hasSubtitle: value));
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
          title: const Text('show Additional Info'),
          value: config.hasAdditionalInfo,
          onChanged: (value) {
            ref
                .read(tileConfigProvider.notifier)
                .change(config.copyWith(hasAdditionalInfo: value));
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
