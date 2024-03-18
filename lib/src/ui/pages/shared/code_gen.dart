import 'package:code_builder/code_builder.dart';
import 'package:flutter/material.dart';

abstract final class CodeGen {
  static Expression voidCallback = Method((m) => m.body = Block()).closure;

  static Expression outlinedButton({
    required Expression child,
    required Expression onPressed,
  }) =>
      InvokeExpression.newOf(refer('OutlinedButton'), [], {
        'onPressed': onPressed,
        'child': child,
      });

  static Expression indexedBuilder({bool lambda = false, Code? body}) =>
      Method((m) => m
        ..requiredParameters.addAll([
          Parameter((p) => p..name = 'context'),
          Parameter((p) => p..name = 'index'),
        ])
        ..lambda = lambda
        ..body = body ?? Block()).closure;
}

extension ReferenceCodeExt on Reference {
  Expression get toStringCode => newInstanceNamed('toString', []);
}

extension AxisCodeExt on Axis {
  Expression get toCode => switch (this) {
        Axis.horizontal => refer('Axis.horizontal'),
        Axis.vertical => refer('Axis.vertical'),
      };
}
