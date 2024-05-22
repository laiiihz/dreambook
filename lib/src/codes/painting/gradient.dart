import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/engine/painting.dart';
import 'package:dreambook/src/codes/painting/alignment.dart';
import 'package:flutter/widgets.dart';

class LinearGradientX extends InvokeExpression {
  LinearGradientX({
    AlignmentGeometry begin = Alignment.centerLeft,
    Expression? begin$,
    AlignmentGeometry end = Alignment.centerRight,
    Expression? end$,
    List<Color>? colors,
    Expression? colors$,
    List<double>? stops,
    Expression? stops$,
    TileMode tileMode = TileMode.clamp,
    Expression? tileMode$,
  }) : super.newOf(
          refer('LinearGradient'),
          [],
          {
            if (begin$ != null) 'begin': begin$ else if (begin != Alignment.centerLeft) 'begin': begin.$exp,
            if (end$ != null) 'end': end$ else if (end != Alignment.centerRight) 'end': end.$exp,
            if (colors$ != null) 'colors': colors$ else if (colors != null) 'colors': literalList(colors.map((e) => e.$exp)),
            if (stops$ != null) 'stops': stops$ else if (stops != null) 'stops': literalList(stops.map((e) => literalNum(e))),
            if (tileMode$ != null) 'tileMode': tileMode$ else if (tileMode != TileMode.clamp) 'tileMode': tileMode.$exp,
          },
        );
}

extension LinearGradientCodeExt on LinearGradient {
  Expression get $exp => LinearGradientX(
      begin: begin, end: end, colors: colors, stops: stops, tileMode: tileMode);
}
