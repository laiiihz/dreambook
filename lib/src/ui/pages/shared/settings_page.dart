import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/theme.dart';
import 'package:dreambook/src/ui/widgets/adaptive_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(context.tr.settings),
          ),
          SliverList.list(children: [
            Consumer(builder: (context, ref, _) {
              return SwitchListTile(
                title: Text(context.tr.darkMode),
                value: ref.watch(themeModeDataProvider) == ThemeMode.dark,
                onChanged: (t) {
                  ref
                      .read(themeModeDataProvider.notifier)
                      .change(t ? ThemeMode.dark : ThemeMode.light);
                },
              );
            }),
          ]),
        ],
      ),
    );
  }
}
