// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_bar.g.dart';

final appBarItem = CodeItem(
  title: (context) => context.tr.appBar,
  code: const TheCode(),
  widget: const TheWidget(),
);

class AppBarConfig {
  AppBarConfig({
    this.showTitle = true,
    this.showLeading = false,
    this.showActions = false,
    this.showBottom = false,
    this.showFlexibleSpace = false,
    this.centerTitle = false,
  });
  final bool showTitle;
  final bool showLeading;
  final bool showActions;
  final bool showFlexibleSpace;
  final bool showBottom;
  final bool centerTitle;

  AppBarConfig copyWith({
    bool? showTitle,
    bool? showLeading,
    bool? showActions,
    bool? showFlexibleSpace,
    bool? showBottom,
    bool? centerTitle,
  }) {
    return AppBarConfig(
      showTitle: showTitle ?? this.showTitle,
      showLeading: showLeading ?? this.showLeading,
      showActions: showActions ?? this.showActions,
      showFlexibleSpace: showFlexibleSpace ?? this.showFlexibleSpace,
      showBottom: showBottom ?? this.showBottom,
      centerTitle: centerTitle ?? this.centerTitle,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  AppBarConfig build() => AppBarConfig();
  void change(AppBarConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'AppBar',
      apiUrl: '/flutter/material/AppBar-class.html',
      named: {
        if (config.showTitle) 'showTitle': refer("const Text('Title')"),
        if (config.centerTitle) 'centerTitle': literalTrue,
        if (config.showLeading)
          'leading': refer('const Icon(Icons.arrow_back)'),
        if (config.showActions)
          'actions': literalConstList([
            refer('IconButton(onPressed: null, icon: Icon(Icons.share))'),
            refer('IconButton(onPressed: null, icon: Icon(Icons.more_vert))'),
          ]),
        if (config.showFlexibleSpace)
          'flexibleSpace': refer('const FlutterLogo(size: 256)'),
        if (config.showBottom)
          'bottom': refer(
              'const PreferredSize(preferredSize: Size.fromHeight(24), child: SizedBox(height: 24, child: Placeholder()),)')
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
      content: Container(
        height: 56 + (config.showBottom ? 24 : 0),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline),
        ),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: config.showLeading
              ? IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back))
              : null,
          title: config.showTitle ? const Text('Title') : null,
          centerTitle: config.centerTitle,
          actions: config.showActions
              ? [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_vert)),
                ]
              : null,
          flexibleSpace:
              config.showFlexibleSpace ? const FlutterLogo(size: 256) : null,
          bottom: config.showBottom
              ? const PreferredSize(
                  preferredSize: Size.fromHeight(24),
                  child: SizedBox(height: 24, child: Placeholder()),
                )
              : null,
        ),
      ),
      configs: [
        SwitchListTile(
          title: const Text('Show Leading'),
          value: config.showLeading,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showLeading: t));
          },
        ),
        SwitchListTile(
          title: const Text('Show Title'),
          value: config.showTitle,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showTitle: t));
          },
        ),
        SwitchListTile(
          title: const Text('Centered Title'),
          value: config.centerTitle,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(centerTitle: t));
          },
        ),
        SwitchListTile(
          title: const Text('Show Actions'),
          value: config.showActions,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showActions: t));
          },
        ),
        SwitchListTile(
          title: const Text('Show Flexible Space'),
          value: config.showFlexibleSpace,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showFlexibleSpace: t));
          },
        ),
        SwitchListTile(
          title: const Text('Show Bottom'),
          value: config.showBottom,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showBottom: t));
          },
        ),
      ],
    );
  }
}
