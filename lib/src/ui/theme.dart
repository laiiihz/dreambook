import 'package:dreambook/src/utils/kv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme.g.dart';

ThemeData appTheme([Brightness brightness = Brightness.light]) {
  const primary = Colors.cyan;
  final colorScheme =
      ColorScheme.fromSeed(seedColor: primary, brightness: brightness);
  return ThemeData(
    colorScheme: colorScheme,
    splashFactory: _platformFactory,
    cupertinoOverrideTheme: CupertinoThemeData(
      brightness: brightness,
      primaryColor: colorScheme.primary,
      applyThemeToAll: true,
      textTheme: CupertinoTextThemeData(primaryColor: colorScheme.primary),
    ),
    useMaterial3: true,
  );
}

InteractiveInkFeatureFactory get _platformFactory {
  if (kIsWeb) {
    return InkRipple.splashFactory;
  } else {
    return InkSparkle.splashFactory;
  }
}

@riverpod
class ThemeModeData extends _$ThemeModeData {
  @override
  ThemeMode build() => KV.darkMode ? ThemeMode.dark : ThemeMode.light;

  void change(ThemeMode mode) {
    state = mode;
    KV.darkMode = mode == ThemeMode.dark;
  }
}

@riverpod
String themeModeImage(ThemeModeImageRef ref) {
  return ref.watch(themeModeDataProvider) == ThemeMode.dark
      ? 'assets/icons/github-mark-white.png'
      : 'assets/icons/github-mark.png';
}
