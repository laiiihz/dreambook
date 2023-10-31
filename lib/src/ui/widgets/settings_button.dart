import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/routes/routes.dart';
import 'package:dreambook/src/ui/pages/shared/settings_page.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: () {
        SettingsRoute().go(context);
      },
      tooltip: context.tr.settings,
      icon: const Icon(Icons.settings_rounded),
    );
  }
}
