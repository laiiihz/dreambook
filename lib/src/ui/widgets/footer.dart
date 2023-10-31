import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final year = DateTime.now().year;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Released under the MIT License.',
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onBackground.withOpacity(0.8),
            ),
          ),
          Text(
            'Copyright © $year laihz.dev',
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onBackground.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
