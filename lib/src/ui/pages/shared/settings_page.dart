import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/routes/routes.dart';
import 'package:dreambook/src/ui/theme.dart';
import 'package:dreambook/src/ui/widgets/adaptive_scaffold.dart';
import 'package:dreambook/src/ui/widgets/resource_license_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'settings/project_license_page.dart';

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
            Consumer(builder: (context, ref, _) {
              return ListTile(
                title: Text(context.tr.language),
                trailing: PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: null,
                        onTap: () {
                          ref.read(appLocaleProvider.notifier).change(null);
                        },
                        child: Text(context.tr.followSystem),
                      ),
                      for (final i in AppLocalizations.supportedLocales)
                        PopupMenuItem(value: i, child: Text(i.name(context)))
                    ];
                  },
                  onSelected: (value) {
                    ref.read(appLocaleProvider.notifier).change(value);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      ref.read(appLocaleProvider).name(context),
                    ),
                  ),
                ),
              );
            }),
            ListTile(
              title: Text(context.tr.projectLicense),
              onTap: () {
                ProjectLicenseRoute().go(context);
              },
            ),
            AboutListTile(
              applicationLegalese: context.tr.copyright(DateTime.now().year),
              aboutBoxChildren: const [
                SizedBox(height: 4),
                ResourceLicenseButton(),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
