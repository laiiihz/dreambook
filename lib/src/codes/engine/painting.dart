import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/engine/engine.dart';
import 'package:flutter/material.dart';

extension ColorExt on Color {
  static _colorValueString(int value) =>
      '0x${value.toRadixString(16).toUpperCase().padLeft(8, 'F')}';
  Expression get $exp => switch (this) {
        Colors.red => refer('Colors').property('red'),
        Colors.green => refer('Colors').property('green'),
        Colors.blue => refer('Colors').property('blue'),
        Colors.black => refer('Colors').property('black'),
        Colors.white => refer('Colors').property('white'),
        Colors.teal => refer('Colors').property('teal'),
        Colors.amber => refer('Colors').property('amber'),
        Colors.transparent => refer('Colors').property('transparent'),
        _ => InvokeExpression.constOf(
            refer('Color'),
            [refer(_colorValueString(value))],
          ),
      };
}

extension ShadowCodeExt on Shadow {
  Expression get $exp => InvokeExpression.newOf(
        refer('Shadow'),
        [],
        {
          'color': color.$exp,
          if (offset != Offset.zero) 'offset': offset.$exp,
          'blurRadius': literalNum(blurRadius),
        },
      );
}

class ShadowX extends InvokeExpression {
  ShadowX({
    Color color = const Color(0xFF000000),
    Expression? color$,
    Offset offset = Offset.zero,
    Expression? offset$,
    double blurRadius = 0.0,
    Expression? blurRadius$,
  }) : super.newOf(
          refer('Shadow'),
          [],
          {
            if (color$ != null)
              'color': color$
            else if (color == const Color(0xFF000000))
              'color': color.$exp,
            if (offset$ != null)
              'offset': offset$
            else if (offset != Offset.zero)
              'offset': offset.$exp,
            if (blurRadius$ != null)
              'blurRadius': blurRadius$
            else if (blurRadius != 0.0)
              'blurRadius': literalNum(blurRadius),
          },
        );
}

class ImageFilterX extends InvokeExpression {
  ImageFilterX.blur({
    double sigmaX = 0.0,
    Expression? sigmaX$,
    double sigmaY = 0.0,
    Expression? sigmaY$,
    TileMode tileMode = TileMode.clamp,
    Expression? tileMode$,
  }) : super.newOf(
          refer('ImageFilter'),
          [],
          {
            if (sigmaX$ != null)
              'sigmaX': sigmaX$
            else if (sigmaX != 0.0)
              'sigmaX': literalNum(sigmaX),
            if (sigmaY$ != null)
              'sigmaY': sigmaY$
            else if (sigmaY != 0.0)
              'sigmaY': literalNum(sigmaY),
            if (tileMode$ != null)
              'tileMode': tileMode$
            else if (tileMode != TileMode.clamp)
              'tileMode': literalNum(0.0),
          },
          [],
          'blur',
        );
  ImageFilterX.dilate({
    double radiusX = 0.0,
    Expression? radiusX$,
    double radiusY = 0.0,
    Expression? radiusY$,
  }) : super.newOf(
          refer('ImageFilter'),
          [],
          {
            if (radiusX$ != null)
              'radiusX': radiusX$
            else if (radiusX != 0.0)
              'radiusX': literalNum(radiusX),
            if (radiusY$ != null)
              'radiusY': radiusY$
            else if (radiusY != 0.0)
              'radiusY': literalNum(radiusY),
          },
          [],
          'dilate',
        );
  ImageFilterX.erode({
    double radiusX = 0.0,
    Expression? radiusX$,
    double radiusY = 0.0,
    Expression? radiusY$,
  }) : super.newOf(
          refer('ImageFilter'),
          [],
          {
            if (radiusX$ != null)
              'radiusX': radiusX$
            else if (radiusX != 0.0)
              'radiusX': literalNum(radiusX),
            if (radiusY$ != null)
              'radiusY': radiusY$
            else if (radiusY != 0.0)
              'radiusY': literalNum(radiusY),
          },
          [],
          'erode',
        );

  ImageFilterX.compose({required Expression outer, required Expression inner})
      : super.newOf(
          refer('ImageFilter'),
          [],
          {
            'outer': outer,
            'inner': inner,
          },
          [],
          'compose',
        );
}

extension TileModeCodeExt on TileMode {
  Expression get $exp => refer('TileMode').property(name);
}

extension BlendModeCodeExt on BlendMode {
  Expression get $exp => refer('BlendMode').property(name);
}

extension ClipCodeExt on Clip {
  Expression get $exp => refer('Clip').property(name);
}
