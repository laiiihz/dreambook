import 'dart:ui';

import 'package:code_builder/code_builder.dart';

extension OffsetCodeExt on Offset {
  Expression get $exp => switch (this) {
        Offset.zero => refer('Offset').property('zero'),
        _ => InvokeExpression.newOf(
            refer('Offset'), [literalNum(dx), literalNum(dy)]),
      };
  test() {
    Offset.zero;
    Offset(dx, dy);
  }
}

extension SizeCodeExt on Size {
  Expression get $exp => switch (this) {
        Size.zero => refer('Size').property('zero'),
        Size.infinite => refer('Size').property('infinite'),
        Size(:final width, :final height) => switch ((width, height)) {
            (double.infinity, _) => refer('Size')
                .newInstanceNamed('fromHeight', [literalNum(height)]),
            (_, double.infinity) =>
              refer('Size').newInstanceNamed('fromWidth', [literalNum(width)]),
            _ when width == height =>
              refer('Size').newInstanceNamed('square', [literalNum(width)]),
            _ => refer('Size')
                .newInstance([literalNum(width), literalNum(height)]),
          },
      };
}
