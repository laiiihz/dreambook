import 'package:flutter/material.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class CodeHighlight {
  CodeHighlight(this.context);
  final BuildContext context;

  static late final HighlighterTheme light;
  static late final HighlighterTheme dark;

  static CodeHighlight of(BuildContext context) => CodeHighlight(context);

  static Future<void> ensureInitialized() async {
    await Highlighter.initialize(['dart']);
    light = await HighlighterTheme.loadLightTheme();
    dark = await HighlighterTheme.loadDarkTheme();
  }

  TextSpan highlight(String code) {
    final theme =
        Theme.of(context).brightness == Brightness.light ? light : dark;
    return Highlighter(language: 'dart', theme: theme).highlight(code);
  }
}
