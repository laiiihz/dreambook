import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeModeButton extends ConsumerWidget {
  const ThemeModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeDataProvider);
    return IconButton(
      tooltip: themeMode == ThemeMode.dark
          ? context.tr.darkMode
          : context.tr.lightMode,
      onPressed: () {
        ref.read(themeModeDataProvider.notifier).change(
              themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
            );
      },
      icon: switch (themeMode) {
        ThemeMode.dark => const Icon(Icons.dark_mode_rounded),
        ThemeMode.light => const Icon(Icons.light_mode_rounded),
        ThemeMode.system => const SizedBox.shrink(),
      },
    );
  }
}
