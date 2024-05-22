import 'package:code_builder/code_builder.dart';
import 'package:flutter/material.dart';

class BoxDecorationX extends InvokeExpression {
  BoxDecorationX({
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BlendMode? backgroundBlendMode,
    BoxShape shape = BoxShape.rectangle,
  }) : super.newOf(refer('BoxDecoration'), [], {});
}
