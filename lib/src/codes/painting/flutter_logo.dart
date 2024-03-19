import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/material/material.dart';
import 'package:flutter/material.dart';

/// code expression for [FlutterLogo]
class FlutterLogoX extends InvokeExpression {
  FlutterLogoX({
    double? size,
    Expression? size$,
    Color textColor = const Color(0xFF757575),
    Expression? textColor$,
    FlutterLogoStyle style = FlutterLogoStyle.markOnly,
    Expression? style$,
    Duration duration = const Duration(milliseconds: 750),
    Expression? duration$,
    Curve curve = Curves.fastOutSlowIn,
    Expression? curve$,
  }) : super.newOf(
          refer('FlutterLogo'),
          [],
          {
            if (size != null) 'size': literalNum(size),
            if (size$ != null) 'size': size$,
            if (textColor != const Color(0xFF757575))
              'textColor': textColor.$exp,
            if (textColor$ != null) 'textColor': textColor$,
            if (style != FlutterLogoStyle.markOnly)
              'style': FlutterLogoStyle.markOnly.$exp,
            if (style$ != null) 'style': style$,
            if (duration != const Duration(milliseconds: 750))
              'duration': duration.$exp,
            if (duration$ != null) 'duration': duration$,
            if (curve != Curves.fastOutSlowIn) 'curve': curve.$exp,
            if (curve$ != null) 'curve': curve$,
          },
        );
}

extension FlutterLogoCodeExt on FlutterLogo {
  Expression get $exp => InvokeExpression.newOf(
        refer('FlutterLogo'),
        [],
        {
          if (size != null) 'size': literalNum(size!),
          if (textColor != const Color(0xFF757575)) 'textColor': textColor.$exp,
          if (style != FlutterLogoStyle.markOnly) 'style': style.$exp,
          if (duration != const Duration(milliseconds: 750))
            'duration': duration.$exp,
          if (curve != Curves.fastOutSlowIn) 'curve': curve.$exp,
        },
      );
}

extension FlutterLogoStyleCodeExt on FlutterLogoStyle {
  Expression get $exp => switch (this) {
        FlutterLogoStyle.markOnly => refer('FlutterLogoStyle.markOnly'),
        FlutterLogoStyle.horizontal => refer('FlutterLogoStyle.horizontal'),
        FlutterLogoStyle.stacked => refer('FlutterLogoStyle.stacked'),
      };
}
