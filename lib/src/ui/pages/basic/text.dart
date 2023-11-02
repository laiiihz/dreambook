// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';

part 'text.g.dart';

final textItem = CodeItem(
  title: (context) => context.tr.text,
  code: const TheCode(),
  widget: const TheWidget(),
);

class TextConfig {
  TextConfig({
    this.fontSize = 14,
    this.changeColor = false,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.letterSpacing = 0,
    this.wordSpacing = 0,
    this.height = 1.1,
    this.hasForeground = false,
    this.hasBackground = false,
  });

  final double fontSize;
  final bool changeColor;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double letterSpacing;
  final double wordSpacing;
  final double height;
  final bool hasForeground;
  final bool hasBackground;

  TextConfig copyWith({
    double? fontSize,
    bool? changeColor,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    bool? hasForeground,
    bool? hasBackground,
  }) {
    return TextConfig(
      fontSize: fontSize ?? this.fontSize,
      changeColor: changeColor ?? this.changeColor,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      height: height ?? this.height,
      hasForeground: hasForeground ?? this.hasForeground,
      hasBackground: hasBackground ?? this.hasBackground,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  TextConfig build() => TextConfig();
  void change(TextConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'Text',
      apiUrl: '/flutter/widgets/Text-class.html',
      named: {
        'style': InvokeExpression.newOf(
          refer('TextStyle'),
          [],
          {
            'fontSize': literal(config.fontSize),
            if (config.changeColor) 'color': refer('Colors.teal'),
            if (config.fontWeight != FontWeight.normal)
              'fontWeight': refer('FontWeight.w${config.fontWeight.value}'),
          },
        ),
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    Paint? foreground, background;
    if (!config.changeColor) {
      foreground = config.hasForeground ? (Paint()..color = Colors.red) : null;
    }
    return WidgetWithConfiguration(
      content: Text(
        'A Message from Astral Express',
        style: TextStyle(
          fontSize: config.fontSize,
          color: config.changeColor ? Colors.teal : null,
          fontWeight: config.fontWeight,
          fontStyle: config.fontStyle,
          letterSpacing: config.letterSpacing,
          wordSpacing: config.wordSpacing,
          height: config.height,
          foreground: foreground,
          background:
              config.hasBackground ? (Paint()..color = Colors.green) : null,
        ),
      ),
      configs: [
        SlidableTile(
          title: 'Font Size',
          value: config.fontSize,
          min: 10,
          max: 32,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(fontSize: t));
          },
        ),
        SwitchListTile(
          title: const Text('Change Color'),
          value: config.changeColor,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(changeColor: t));
          },
        ),
        MenuTile(
          title: 'Font Weight',
          items: FontWeight.values,
          current: config.fontWeight,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(fontWeight: t));
          },
          contentBuilder: (t) => '${t.value}',
        ),
        MenuTile(
          title: 'Font Style',
          items: FontStyle.values,
          current: config.fontStyle,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(fontStyle: t));
          },
          contentBuilder: (t) => t.name,
        ),
        SlidableTile(
          title: 'Letter Spacing',
          value: config.letterSpacing,
          min: 0,
          max: 16,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(letterSpacing: t));
          },
        ),
        SlidableTile(
          title: 'Word Spacing',
          value: config.wordSpacing,
          min: 0,
          max: 16,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(wordSpacing: t));
          },
        ),
        SlidableTile(
          title: 'Height',
          value: config.height,
          min: 0.9,
          max: 2,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(height: t));
          },
        ),
        SwitchListTile(
          title: const Text('Has Foreground'),
          value: config.hasForeground,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(hasForeground: t));
          },
        ),
        SwitchListTile(
          title: const Text('Has Background'),
          value: config.hasBackground,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(hasBackground: t));
          },
        ),
      ],
    );
  }
}
