import 'package:code_builder/code_builder.dart';
import 'package:flutter/widgets.dart';

extension AlignmentCodeExt on Alignment {
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

  Expression get $exp => switch (this) {
        Alignment.bottomCenter => refer('Alignment').property('bottomCenter'),
        Alignment.bottomLeft => refer('Alignment').property('bottomLeft'),
        Alignment.bottomRight => refer('Alignment').property('bottomRight'),
        Alignment.center => refer('Alignment').property('center'),
        Alignment.centerLeft => refer('Alignment').property('centerLeft'),
        Alignment.centerRight => refer('Alignment').property('centerRight'),
        Alignment.topCenter => refer('Alignment').property('topCenter'),
        Alignment.topLeft => refer('Alignment').property('topLeft'),
        Alignment.topRight => refer('Alignment').property('topRight'),
        _ => InvokeExpression.newOf(
            refer('Alignment'),
            [literalNum(x), literalNum(y)],
          ),
      };
}

extension AlignmentDirectionalCodeExt on AlignmentDirectional {
  Expression get $exp => switch (this) {
        AlignmentDirectional.topStart =>
          refer('AlignmentDirectional').property('topStart'),
        AlignmentDirectional.topCenter =>
          refer('AlignmentDirectional').property('topCenter'),
        AlignmentDirectional.topEnd =>
          refer('AlignmentDirectional').property('topEnd'),
        AlignmentDirectional.centerStart =>
          refer('AlignmentDirectional').property('centerStart'),
        AlignmentDirectional.center =>
          refer('AlignmentDirectional').property('center'),
        AlignmentDirectional.centerEnd =>
          refer('AlignmentDirectional').property('centerEnd'),
        AlignmentDirectional.bottomStart =>
          refer('AlignmentDirectional').property('bottomStart'),
        AlignmentDirectional.bottomCenter =>
          refer('AlignmentDirectional').property('bottomCenter'),
        AlignmentDirectional.bottomEnd =>
          refer('AlignmentDirectional').property('bottomEnd'),
        _ => InvokeExpression.newOf(
            refer('AlignmentDirectional'), [literalNum(start), literalNum(y)]),
      };

  String get name => switch (this) {
        AlignmentDirectional.topStart => 'topStart',
        AlignmentDirectional.topCenter => 'topCenter',
        AlignmentDirectional.topEnd => 'topEnd',
        AlignmentDirectional.centerStart => 'centerStart',
        AlignmentDirectional.center => 'center',
        AlignmentDirectional.centerEnd => 'centerEnd',
        AlignmentDirectional.bottomStart => 'bottomStart',
        AlignmentDirectional.bottomCenter => 'bottomCenter',
        AlignmentDirectional.bottomEnd => 'bottomEnd',
        _ => 'Value',
      };
}

extension AlignmentGeometryCodeExt on AlignmentGeometry {
  Expression get $exp => switch (this) {
        Alignment() => (this as Alignment).$exp,
        AlignmentDirectional() => (this as AlignmentDirectional).$exp,
        _ => throw UnimplementedError(),
      };
}
