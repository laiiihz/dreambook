import 'package:flutter/material.dart';

class AboutButton extends StatelessWidget {
  const AboutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showAboutDialog(context: context, applicationName: 'Dreambook');
      },
      icon: const Icon(Icons.info_outline_rounded),
    );
  }
}
