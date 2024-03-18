import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/engine/text.dart';
import 'package:dreambook/src/codes/painting/text_painter.dart';
import 'package:dreambook/src/codes/painting/text_style.dart';
import 'package:flutter/material.dart';

/// code expression for [Text]
class DText extends InvokeExpression {
  DText(
    Expression ref, {
    DTextStyle? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
  }) : super.newOf(
          refer('Text'),
          [ref],
          {
            if (style != null) 'style': style,
            if (textAlign != null) 'textAlign': textAlign.toCode,
            if (textDirection != null) 'textDirection': textDirection.$exp,
            if (softWrap != null) 'softWrap': literalBool(softWrap),
            if (overflow != null) 'overflow': overflow.toCode,
            if (maxLines != null) 'maxLines': literalNum(maxLines),
          },
        );
}
