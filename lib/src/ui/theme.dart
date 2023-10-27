import 'package:dreambook/src/utils/kv.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme.g.dart';

ThemeData appTheme([Brightness brightness = Brightness.light]) {
  return ThemeData(
    colorScheme:
        ColorScheme.fromSeed(seedColor: Colors.cyan, brightness: brightness),
    splashFactory: InkSparkle.splashFactory,
    useMaterial3: true,
  );
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
