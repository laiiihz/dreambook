import 'package:dreambook/src/routes/routes.dart';
import 'package:dreambook/src/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: appTheme(),
      darkTheme: appTheme(Brightness.dark),
      routerConfig: ref.watch(appRoutesProvider),
    );
  }
}
