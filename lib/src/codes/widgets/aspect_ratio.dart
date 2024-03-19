import 'package:code_builder/code_builder.dart';

class AspectRatioX extends InvokeExpression {
  AspectRatioX({
    required double aspectRatio,
    Expression? aspectRatio$,
    Expression? child,
  }) : super.newOf(refer('AspectRatio'), [], {
          if (aspectRatio$ != null)
            'aspectRatio': aspectRatio$
          else
            'aspectRatio': literalNum(aspectRatio),
          if (child != null) 'child': child,
        });
}
