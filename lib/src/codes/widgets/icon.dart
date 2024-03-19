import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/engine/painting.dart';
import 'package:flutter/material.dart';

class IconX extends InvokeExpression {
  IconX(
    Expression icon, {
    double? size,
    Expression? size$,
    double? fill,
    Expression? fill$,
    double? weight,
    Expression? weight$,
    double? grade,
    Expression? grade$,
    double? opticalSize,
    Expression? opticalSize$,
    Color? color,
    Expression? color$,
    List<Shadow>? shadows,
    List<Expression>? shadows$,
  }) : super.newOf(refer('Icon'), [], {
          'icon': icon,
          if (size != null) 'size': literalNum(size),
          if (size$ != null) 'size': size$,
          if (fill != null) 'fill': literalNum(fill),
          if (fill$ != null) 'fill': fill$,
          if (weight != null) 'weight': literalNum(weight),
          if (weight$ != null) 'weight': weight$,
          if (grade != null) 'grade': literalNum(grade),
          if (grade$ != null) 'grade': grade$,
          if (opticalSize != null) 'opticalSize': literalNum(opticalSize),
          if (opticalSize$ != null) 'opticalSize': opticalSize$,
          if (color != null) 'color': color.$exp,
          if (color$ != null) 'color': color$,
          if (shadows != null)
            'shadows': literalList(shadows.map((e) => e.$exp).toList()),
          if (shadows$ != null) 'shadows': literalList(shadows$),
        });
}
