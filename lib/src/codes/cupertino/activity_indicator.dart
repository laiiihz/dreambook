import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/cupertino/cupertino.dart';
import 'package:flutter/cupertino.dart';

class CupertinoActivityIndicatorX extends InvokeExpression {
  CupertinoActivityIndicatorX({
    Color? color,
    Expression? color$,
    bool animating = true,
    Expression? animating$,
    double radius = 10,
    Expression? radius$,
  }) : super.newOf(refer('CupertinoActivityIndicator'), [], {
          if (color$ != null)
            'color': color$
          else if (color != null)
            'color': color.$exp,
          if (animating$ != null)
            'animating': animating$
          else if (!animating)
            'animating': literalBool(false),
          if (radius$ != null)
            'radius': radius$
          else if (radius != 10)
            'radius': literalNum(radius),
        });
  CupertinoActivityIndicatorX.partiallyRevealed({
    Color? color,
    Expression? color$,
    double radius = 10,
    Expression? radius$,
    double progress = 1.0,
    Expression? progress$,
  }) : super.newOf(
            refer('CupertinoActivityIndicator'),
            [],
            {
              if (color$ != null)
                'color': color$
              else if (color != null)
                'color': color.$exp,
              if (radius$ != null)
                'radius': radius$
              else if (radius != 10)
                'radius': literalNum(radius),
              if (progress$ != null)
                'progress': progress$
              else if (progress != 1.0)
                'progress': literalNum(progress),
            },
            [],
            'partiallyRevealed');
}
