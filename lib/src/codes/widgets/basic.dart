import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/engine/basic_types.dart';
import 'package:dreambook/src/codes/engine/engine.dart';
import 'package:dreambook/src/codes/engine/painting.dart';
import 'package:dreambook/src/codes/engine/text.dart';
import 'package:dreambook/src/codes/painting/alignment.dart';
import 'package:dreambook/src/codes/rendering/rendering.dart';
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

class FlexX extends FlexBaseX {
  FlexX({
    required Axis direction,
    Expression? direction$,
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
  }) : super('Flex', extra: {
          if (direction$ != null)
            'direction': direction$
          else
            'direction': direction.$exp,
        });
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
    this.extra = const {},
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
          ...extra,
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
  final Map<String, Expression> extra;
}

class BackdropFilterX extends InvokeExpression {
  BackdropFilterX({
    Expression? filter,
    Expression? child,
    BlendMode blendMode = BlendMode.srcOver,
    Expression? blendMode$,
  }) : super.newOf(refer('BackdropFilter'), [], {
          if (filter != null) 'filter': filter,
          if (child != null) 'child': child,
          if (blendMode$ != null)
            'blendMode': blendMode$
          else if (blendMode != BlendMode.srcOver)
            'blendMode': blendMode.$exp,
        });
}

class StackX extends InvokeExpression {
  StackX({
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    Expression? alignment$,
    TextDirection? textDirection,
    Expression? textDirection$,
    StackFit fit = StackFit.loose,
    Expression? fit$,
    Clip clipBehavior = Clip.hardEdge,
    Expression? clipBehavior$,
    List<Expression> children = const <Expression>[],
  }) : super.newOf(refer('Stack'), [], {
          if (alignment$ != null)
            'alignment': alignment$
          else if (alignment != AlignmentDirectional.topStart)
            'alignment': alignment.$exp,
          if (textDirection$ != null)
            'textDirection': textDirection$
          else if (textDirection != null)
            'textDirection': textDirection.$exp,
          if (fit$ != null)
            'fit': fit$
          else if (fit != StackFit.loose)
            'fit': fit.$exp,
          if (clipBehavior$ != null)
            'clipBehavior': clipBehavior$
          else if (clipBehavior != Clip.hardEdge)
            'clipBehavior': clipBehavior.$exp,
          if (children.isNotEmpty) 'children': literalList(children),
        });
}

class ClipRectX extends InvokeExpression {
  ClipRectX({
    Clip clipBehavior = Clip.hardEdge,
    Expression? clipBehavior$,
    Expression? child,
  }) : super.newOf(
          refer('ClipRect'),
          [],
          {
            if (clipBehavior$ != null)
              'clipBehavior': clipBehavior$
            else if (clipBehavior != Clip.hardEdge)
              'clipBehavior': clipBehavior.$exp,
            if (child != null) 'child': child,
          },
        );
}

class SizedBoxX extends InvokeExpression {
  SizedBoxX._(
      {String? suffix, Map<String, Expression>? extra, Expression? child})
      : super.newOf(
          refer('SizedBox'),
          [],
          {if (extra != null) ...extra, if (child != null) 'child': child},
          [],
          suffix,
        );

  factory SizedBoxX({
    double? width,
    Expression? width$,
    double? height,
    Expression? height$,
    Expression? child,
  }) =>
      SizedBoxX._(
        extra: {
          if (width$ != null)
            'width': width$
          else if (width != null)
            'width': literalNum(width),
          if (height$ != null)
            'height': height$
          else if (height != null)
            'height': literalNum(height),
        },
        child: child,
      );

  factory SizedBoxX.expand({Expression? child}) =>
      SizedBoxX._(suffix: 'expand', child: child);
  factory SizedBoxX.fromSize({
    Size? size,
    Expression? size$,
    Expression? child,
  }) =>
      SizedBoxX._(
        suffix: 'fromSize',
        extra: {
          if (size$ != null)
            'size': size$
          else if (size != null)
            'size': size.$exp,
        },
        child: child,
      );
  factory SizedBoxX.shrink({Expression? child}) => SizedBoxX._(
        suffix: 'shrink',
        child: child,
      );
  factory SizedBoxX.square(
          {double? dimension, Expression? dimension$, Expression? child}) =>
      SizedBoxX._(
        suffix: 'square',
        extra: {},
        child: child,
      );
  test() {
    SizedBox.square();
  }
}
