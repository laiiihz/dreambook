import 'package:code_builder/code_builder.dart';
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
