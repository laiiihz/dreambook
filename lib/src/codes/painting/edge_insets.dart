import 'package:code_builder/code_builder.dart';
import 'package:flutter/widgets.dart';

extension EdgeInsetsCodeExt on EdgeInsets {
  Expression get $exp {
    final verticalSame = left == right;
    final horizontalSame = top == bottom;

    if (verticalSame && horizontalSame) {
      if (left == top) {
        return InvokeExpression.constOf(
            refer('EdgeInsets'), [literalNum(top)], {}, [], 'all');
      } else {
        return InvokeExpression.constOf(
          refer('EdgeInsets'),
          [],
          {
            if (left != 0) 'horizontal': literalNum(left),
            if (top != 0) 'vertical': literalNum(top),
          },
          [],
          'symmetric',
        );
      }
    } else {
      return InvokeExpression.constOf(
        refer('EdgeInsets'),
        [],
        {
          if (left != 0) 'left': literalNum(left),
          if (top != 0) 'top': literalNum(top),
          if (right != 0) 'right': literalNum(right),
          if (bottom != 0) 'bottom': literalNum(bottom),
        },
        [],
        'only',
      );
    }
  }
}
