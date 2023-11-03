import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/routes/routes.dart';
import 'package:dreambook/src/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      onGenerateTitle: (context) => context.tr.appName,
      theme: appTheme(),
      darkTheme: appTheme(Brightness.dark),
      themeMode: ref.watch(themeModeDataProvider),
      routerConfig: ref.watch(appRoutesProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: ref.watch(appLocaleProvider),
    );
  }
}
