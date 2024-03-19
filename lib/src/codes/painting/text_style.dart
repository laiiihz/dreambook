import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/engine/engine.dart';
import 'package:flutter/material.dart';

/// code expression for [TextStyle]
class TextStyleX extends InvokeExpression {
  TextStyleX({
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
  }) : super.newOf(refer('TextStyle'), [], {
          if (color != null) 'color': color.$exp,
          if (backgroundColor != null) 'backgroundColor': backgroundColor.$exp,
          if (fontSize != null) 'fontSize': literalNum(fontSize),
          if (fontWeight != null) 'fontWeight': fontWeight.$exp,
          if (fontStyle != null) 'fontStyle': fontStyle.$exp,
          if (letterSpacing != null) 'letterSpacing': literalNum(letterSpacing),
          if (wordSpacing != null) 'wordSpacing': literalNum(wordSpacing),
          if (textBaseline != null) 'textBaseline': textBaseline.$exp,
          if (height != null) 'height': literalNum(height),
        });
}

extension TextStyleCodeExt on TextStyle {
  Expression get $exp => TextStyleX(
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
      );
}
