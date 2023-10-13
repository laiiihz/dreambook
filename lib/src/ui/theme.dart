import 'package:flutter/material.dart';

ThemeData appTheme([Brightness brightness = Brightness.light]) {
  return ThemeData(
    colorScheme:
        ColorScheme.fromSeed(seedColor: Colors.cyan, brightness: brightness),
        splashFactory: InkSparkle.splashFactory,
    useMaterial3: true,
  );
}
