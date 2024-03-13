import 'package:code_builder/code_builder.dart';
import 'package:flutter/material.dart';

abstract final class CodeGen {
  static final Expression voidCallback =
      Method((m) => m.body = Block()).closure;
}

extension EdgeInsetsCodeExt on EdgeInsets {
  Expression get toCode {
    final verticalSame = left == right;
    final horizontalSame = top == bottom;

    if (verticalSame && horizontalSame) {
      if (left == top) {
        return InvokeExpression.constOf(
            refer('EdgeInsets'), [literalNum(top)], {}, [], 'all');
      } else {
        return InvokeExpression.constOf(
          refer('EdgeInsets'),
          [],
          {
            if (left != 0) 'horizontal': literalNum(left),
            if (top != 0) 'vertical': literalNum(top),
          },
          [],
          'symmetric',
        );
      }
    } else {
      return InvokeExpression.constOf(
        refer('EdgeInsets'),
        [],
        {
          if (left != 0) 'left': literalNum(left),
          if (top != 0) 'top': literalNum(top),
          if (right != 0) 'right': literalNum(right),
          if (bottom != 0) 'bottom': literalNum(bottom),
        },
        [],
        'only',
      );
    }
  }
}

extension AxisCodeExt on Axis {
  Expression get toCode => switch (this) {
        Axis.horizontal => refer('Axis.horizontal'),
        Axis.vertical => refer('Axis.vertical'),
      };
}

extension TextCodeExt on Text {
  Expression toCode([Expression? customText]) {
    return InvokeExpression.newOf(
      refer('Text'),
      [customText ?? literalString(data ?? '')],
      {
        if (style != null) 'textStyle': style!.toCode,
      },
    );
  }
}

extension TextStyleCodeExt on TextStyle {
  Expression get toCode {
    return InvokeExpression.newOf(
      refer('TextStyle'),
      [],
      {
        if (color != null) 'color': color!.toCode,
        if (fontSize != null) 'fontSize': literalNum(fontSize!),
        if (fontWeight != null) 'fontWeight': fontWeight!.toCode,
      },
    );
  }
}

extension ColorCodeExt on Color {
  String get valueString =>
      '0x${value.toRadixString(16).toUpperCase().padLeft(8, 'F')}';
  Expression get toCode =>
      InvokeExpression.constOf(refer('Color'), [refer(valueString)]);
}

extension FontWeightCodeExt on FontWeight {
  Expression get toCode => switch (this) {
        FontWeight.bold => refer('FontWeight.bold'),
        FontWeight.normal => refer('FontWeight.normal'),
        _ => refer('FontWeiht.w$value'),
      };
}

extension FlutterLogoCodeExt on FlutterLogo {
  Expression get toCode => InvokeExpression.constOf(refer('FlutterLogo'), []);
}
