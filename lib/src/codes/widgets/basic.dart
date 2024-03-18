import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/engine/text.dart';
import 'package:dreambook/src/codes/rendering/flex.dart';
import 'package:flutter/material.dart';

class ColumnX extends FlexBaseX {
  ColumnX({
    super.mainAxisAlignment = MainAxisAlignment.start,
    super.mainAxisAlignment$,
    super.mainAxisSize = MainAxisSize.max,
    super.mainAxisSize$,
    super.crossAxisAlignment = CrossAxisAlignment.center,
    super.crossAxisAlignment$,
    super.textDirection,
    super.textDirection$,
    super.verticalDirection = VerticalDirection.down,
    super.verticalDirection$,
    super.textBaseline,
    super.textBaseline$,
    super.children,
  }) : super('Column');
}

class RowX extends FlexBaseX {
  RowX({
    super.mainAxisAlignment = MainAxisAlignment.start,
    super.mainAxisAlignment$,
    super.mainAxisSize = MainAxisSize.max,
    super.mainAxisSize$,
    super.crossAxisAlignment = CrossAxisAlignment.center,
    super.crossAxisAlignment$,
    super.textDirection,
    super.textDirection$,
    super.verticalDirection = VerticalDirection.down,
    super.verticalDirection$,
    super.textBaseline,
    super.textBaseline$,
    super.children,
  }) : super('Row');
}

class FlexBaseX extends InvokeExpression {
  FlexBaseX(
    this.targetName, {
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisAlignment$,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisSize$,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.crossAxisAlignment$,
    this.textDirection,
    this.textDirection$,
    this.verticalDirection = VerticalDirection.down,
    this.verticalDirection$,
    this.textBaseline,
    this.textBaseline$,
    this.children,
  }) : super.newOf(refer(targetName), [], {
          if (mainAxisAlignment != MainAxisAlignment.start)
            'mainAxisAlignment': mainAxisAlignment.$exp,
          if (mainAxisAlignment$ != null)
            'mainAxisAlignment': mainAxisAlignment$,
          if (mainAxisSize != MainAxisSize.max)
            'mainAxisSize': mainAxisSize.$exp,
          if (mainAxisSize$ != null) 'mainAxisSize': mainAxisSize$,
          if (crossAxisAlignment != CrossAxisAlignment.center)
            'crossAxisAlignment': crossAxisAlignment.$exp,
          if (crossAxisAlignment$ != null)
            'crossAxisAlignment': crossAxisAlignment$,
          if (textDirection != null) 'textDirection': textDirection.$exp,
          if (textDirection$ != null) 'textDirection': textDirection$,
          if (verticalDirection != VerticalDirection.down)
            'verticalDirection': verticalDirection.$exp,
          if (verticalDirection$ != null)
            'verticalDirection': verticalDirection$,
          if (textBaseline != null) 'textBaseline': textBaseline.$exp,
          if (textBaseline$ != null) 'textBaseline': textBaseline$,
          if (children != null) 'children': literalList(children),
        });
  final String targetName;
  final MainAxisAlignment mainAxisAlignment;
  final Expression? mainAxisAlignment$;
  final MainAxisSize mainAxisSize;
  final Expression? mainAxisSize$;
  final CrossAxisAlignment crossAxisAlignment;
  final Expression? crossAxisAlignment$;
  final TextDirection? textDirection;
  final Expression? textDirection$;
  final VerticalDirection verticalDirection;
  final Expression? verticalDirection$;
  final TextBaseline? textBaseline;
  final Expression? textBaseline$;
  final List<Expression>? children;
}
