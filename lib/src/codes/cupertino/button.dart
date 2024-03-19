import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/cupertino/cupertino.dart';
import 'package:flutter/cupertino.dart';

class CupertinoButtonX extends InvokeExpression {
  CupertinoButtonX.raw(
    String? ext, {
    EdgeInsets? padding,
    Expression? padding$,
    double? pressedOpacity = 0.4,
    Expression? pressedOpacity$,
    required Expression onPressed,
    required Expression child,
  }) : super.newOf(
          refer('CupertinoButton'),
          [],
          {
            if (padding$ != null)
              'padding': padding$
            else if (padding != null)
              'padding': padding.$exp,
            if (pressedOpacity$ != null)
              'pressedOpacity': pressedOpacity$
            else if (pressedOpacity != 0.4 || pressedOpacity != null)
              'pressedOpacity': literalNum(pressedOpacity!),
            'onPressed': onPressed,
            'child': child,
          },
          [],
          ext,
        );
  factory CupertinoButtonX({
    EdgeInsets? padding,
    Expression? padding$,
    double? pressedOpacity = 0.4,
    Expression? pressedOpacity$,
    required Expression onPressed,
    required Expression child,
  }) {
    return CupertinoButtonX.raw(
      null,
      padding: padding,
      padding$: padding$,
      pressedOpacity: pressedOpacity,
      pressedOpacity$: pressedOpacity$,
      onPressed: onPressed,
      child: child,
    );
  }
  factory CupertinoButtonX.filled({
    EdgeInsets? padding,
    Expression? padding$,
    double? pressedOpacity = 0.4,
    Expression? pressedOpacity$,
    required Expression onPressed,
    required Expression child,
  }) {
    return CupertinoButtonX.raw(
      'filled',
      padding: padding,
      padding$: padding$,
      pressedOpacity: pressedOpacity,
      pressedOpacity$: pressedOpacity$,
      onPressed: onPressed,
      child: child,
    );
  }
}
