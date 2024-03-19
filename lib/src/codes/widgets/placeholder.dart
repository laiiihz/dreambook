import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/engine/painting.dart';
import 'package:flutter/widgets.dart';

extension PlaceholderCodeExt on Placeholder {
  Expression get $exp => InvokeExpression.newOf(
        refer('Placeholder'),
        [],
        {
          if (color != const Color(0xFF455A64)) 'color': color.$exp,
          if (strokeWidth != 2) 'strokeWidth': literalNum(strokeWidth),
        },
      );
}

class PlaceholderX extends InvokeExpression {
  PlaceholderX({
    Expression? child,
  }) : super.newOf(refer('Placeholder'), [], {
          if (child != null) 'child': child,
        });
}
