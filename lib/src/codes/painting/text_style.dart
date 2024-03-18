import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/engine/text.dart';
import 'package:flutter/material.dart';

/// code expression for [TextStyle]
class DTextStyle extends InvokeExpression {
  DTextStyle({
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
          // if (color != null) 'color': color.toCode,
          if (backgroundColor != null)
            // 'backgroundColor': backgroundColor.toCode,
            if (fontSize != null) 'fontSize': literalNum(fontSize),
          if (fontWeight != null) 'fontWeight': fontWeight.$exp,
          if (fontStyle != null) 'fontStyle': fontStyle.$exp,
          if (letterSpacing != null) 'letterSpacing': literalNum(letterSpacing),
          if (wordSpacing != null) 'wordSpacing': literalNum(wordSpacing),
          if (textBaseline != null) 'textBaseline': textBaseline.$exp,
          if (height != null) 'height': literalNum(height),
        });
}
