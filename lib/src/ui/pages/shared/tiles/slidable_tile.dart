import 'package:flutter/material.dart';

class SlidableTile extends StatelessWidget {
  const SlidableTile(
      {super.key,
      required this.title,
      this.min = 0,
      this.max = 1.0,
      required this.value,
      required this.onChanged});
  final String title;
  final double min;
  final double max;
  final double value;
  final ValueChanged<double> onChanged;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16.0, end: 24.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: colorScheme.onSurface),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child:
                Slider(value: value, onChanged: onChanged, min: min, max: max),
          ),
        ],
      ),
    );
  }
}
