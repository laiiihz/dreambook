import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/painting/alignment.dart';
import 'package:flutter/material.dart';

class AlignX extends InvokeExpression {
  AlignX({
    Alignment alignment = Alignment.center,
    Expression? alignment$,
    double? widthFactor,
    Expression? widthFactor$,
    double? heightFactor,
    Expression? heightFactor$,
    Expression? child,
  }) : super.newOf(refer('Align'), [], {
          if (alignment$ != null)
            'alignment': alignment$
          else if (alignment != Alignment.center)
            'alignment': alignment.$exp,
          if (widthFactor$ != null)
            'widthFactor': widthFactor$
          else if (widthFactor != null)
            'widthFactor': literalNum(widthFactor),
          if (heightFactor$ != null)
            'heightFactor': heightFactor$
          else if (heightFactor != null)
            'heightFactor': literalNum(heightFactor),
          if (child != null) 'child': child
        });
}
