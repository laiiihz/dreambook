import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/engine/painting.dart';
import 'package:dreambook/src/codes/painting/alignment.dart';
import 'package:dreambook/src/codes/painting/edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContainerX extends InvokeExpression {
  ContainerX({
    Alignment? alignment,
    Expression? alignment$,
    EdgeInsets? padding,
    Expression? padding$,
    Color? color,
    Expression? color$,
    double? width,
    Expression? width$,
    double? height,
    Expression? height$,
    Expression? child,
  }) : super.newOf(refer('Container'), [], {
          if (alignment != null) 'alignment': alignment.$exp,
          if (alignment$ != null) 'alignment': alignment$,
          if (padding != null) 'padding': padding.$exp,
          if (padding$ != null) 'padding': padding$,
          if (color != null) 'color': color.$exp,
          if (color$ != null) 'color': color$,
          if (width != null) 'width': literalNum(width),
          if (width$ != null) 'width': width$,
          if (height != null) 'height': literalNum(height),
          if (height$ != null) 'height': height$,
          if (child != null) 'child': child,
        });
}
