import 'package:dreambook/src/l10n/l10n_helper.dart';
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
            context.tr.releasedMIT,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onBackground.withOpacity(0.8),
            ),
          ),
          Text(
            context.tr.copyright(year),
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
