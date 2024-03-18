import 'package:code_builder/code_builder.dart';
import 'package:flutter/widgets.dart';

extension AlignmentCodeExt on Alignment {
  Expression get $exp => switch (this) {
        Alignment.bottomCenter => refer('Alignment.bottomCenter'),
        Alignment.bottomLeft => refer('Alignment.bottomLeft'),
        Alignment.bottomRight => refer('Alignment.bottomRight'),
        Alignment.center => refer('Alignment.center'),
        Alignment.centerLeft => refer('Alignment.centerLeft'),
        Alignment.centerRight => refer('Alignment.centerRight'),
        Alignment.topCenter => refer('Alignment.topCenter'),
        Alignment.topLeft => refer('Alignment.topLeft'),
        Alignment.topRight => refer('Alignment.topRight'),
        _ => InvokeExpression.newOf(
            refer('Alignment'),
            [literalNum(x), literalNum(y)],
          ),
      };
}

extension AlignmentName on Alignment {
  String get name {
    return switch (this) {
      Alignment.topLeft => 'topLeft',
      Alignment.topCenter => 'topCenter',
      Alignment.topRight => 'topRight',
      Alignment.centerLeft => 'centerLeft',
      Alignment.center => 'center',
      Alignment.centerRight => 'centerRight',
      Alignment.bottomLeft => 'bottomLeft',
      Alignment.bottomCenter => 'bottomCenter',
      Alignment.bottomRight => 'bottomRight',
      _ => 'Value',
    };
  }
}
