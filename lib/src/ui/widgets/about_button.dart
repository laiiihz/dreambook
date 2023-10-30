import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:flutter/material.dart';

class AboutButton extends StatelessWidget {
  const AboutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: context.aboutLabel,
      onPressed: () {
        showAboutDialog(context: context, applicationName: context.tr.appName);
      },
      icon: const Icon(Icons.info_outline_rounded),
    );
  }
}
