// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/engine/text.dart';
import 'package:dreambook/src/codes/painting/text_style.dart';
import 'package:dreambook/src/codes/widgets/stateful_widget.dart';
import 'package:dreambook/src/codes/widgets/text.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_area.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'text.g.dart';

final textItem = CodeItem(
  title: (context) => context.tr.text,
  code: const TheCode(),
  widget: const TheWidget(),
);

const _loremData =
    'frequentia libere quicquid frons curtus quercetum. invetero pluvit prolusio coniuratus molestus corpus suppono. color triginta laeto potum textrix manus pyus obtineo vigilo conspicio redarguo servio custodiae deleo inflatio praetermissio remaneo illis.';

class TextConfig {
  TextConfig({
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.letterSpacing = 0,
    this.wordSpacing = 0,
    this.textBaseline,
    this.height = 1.1,
  });

  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;

  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double letterSpacing;
  final double wordSpacing;
  final TextBaseline? textBaseline;
  final double height;

  TextConfig copyWith({
    TextAlign? textAlign,
    TextDirection? textDirection,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
  }) {
    return TextConfig(
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection ?? this.textDirection,
      softWrap: softWrap ?? this.softWrap,
      overflow: overflow ?? this.overflow,
      maxLines: maxLines ?? this.maxLines,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      textBaseline: textBaseline ?? this.textBaseline,
      height: height ?? this.height,
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
    return CodeArea(
      api: '/flutter/widgets/Text-class.html',
      codes: [
        StatefulWidgetX(
          buildReturn: DText(
            literalString(_loremData),
            textAlign: config.textAlign,
            textDirection: config.textDirection,
            softWrap: config.softWrap,
            overflow: config.overflow,
            maxLines: config.maxLines,
            style: DTextStyle(
              fontWeight: config.fontWeight == FontWeight.normal
                  ? null
                  : config.fontWeight,
              height: config.height == 1.1 ? null : config.height,
              fontSize: config.fontSize == 14 ? null : config.fontSize,
              letterSpacing:
                  config.letterSpacing == 0 ? null : config.letterSpacing,
              wordSpacing: config.wordSpacing == 0 ? null : config.wordSpacing,
            ),
          ),
        ),
      ],
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: Text(
        _loremData,
        textAlign: config.textAlign,
        textDirection: config.textDirection,
        softWrap: config.softWrap,
        overflow: config.overflow,
        maxLines: config.maxLines,
        style: TextStyle(
          fontSize: config.fontSize,
          fontWeight: config.fontWeight,
          letterSpacing: config.letterSpacing,
          wordSpacing: config.wordSpacing,
        ),
      ),
      configs: [
        MenuTile(
          title: 'Text Align',
          items: TextAlign.values,
          current: config.textAlign,
          onTap: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(textAlign: e));
          },
          contentBuilder: (e) => e?.name ?? 'unset',
        ),
        MenuTile(
          title: 'Text Direction',
          items: TextDirection.values,
          current: config.textDirection,
          onTap: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(textDirection: e));
          },
          contentBuilder: (e) => e?.name ?? 'unset',
        ),
        SwitchListTile(
          title: const Text('Softwrap'),
          value: config.softWrap ?? false,
          onChanged: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(softWrap: e));
          },
        ),
        MenuTile(
          title: 'Text Overflow',
          items: TextOverflow.values,
          current: config.overflow,
          onTap: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(overflow: e));
          },
          contentBuilder: (e) => e?.name ?? 'unset',
        ),
        SlidableTile(
          title: 'maxLine',
          min: 1,
          max: 8,
          value: (config.maxLines ?? 8) + .0,
          onChanged: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(maxLines: e.toInt()));
          },
        ),
        SlidableTile(
          title: 'Letter Spacing',
          min: -4,
          max: 4,
          divisions: 8,
          value: config.letterSpacing,
          onChanged: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(letterSpacing: e));
          },
        ),
        SlidableTile(
          title: 'Word Spacing',
          min: -4,
          max: 4,
          divisions: 8,
          value: config.wordSpacing,
          onChanged: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(wordSpacing: e));
          },
        ),
        SlidableTile(
          title: 'Font Size',
          min: 10,
          max: 22,
          divisions: 12,
          value: config.fontSize,
          onChanged: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(fontSize: e));
          },
        ),
        MenuTile(
          title: 'Font Weight',
          items: FontWeight.values,
          current: config.fontWeight,
          onTap: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(fontWeight: e));
          },
          contentBuilder: (e) => e.name,
        ),
        MenuTile(
          title: 'Font Style',
          items: FontStyle.values,
          current: config.fontStyle,
          onTap: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(fontStyle: e));
          },
          contentBuilder: (e) => e.name,
        ),
        SlidableTile(
          title: 'Line Height',
          min: 0.5,
          max: 1.5,
          divisions: 10,
          value: config.height,
          onChanged: (e) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(height: e));
          },
        ),
      ],
    );
  }
}
