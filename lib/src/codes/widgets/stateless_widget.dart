import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/widgets/stateful_widget.dart';
import 'package:flutter/material.dart';

class StatelessWidgetX extends ToCode {
  StatelessWidgetX({this.beforeBuildReturn, required this.buildReturn});

  final List<Code>? beforeBuildReturn;
  final Expression buildReturn;

  Method buildMethod() {
    return Method((m) {
      m
        ..name = 'build'
        ..annotations.add(refer('override'))
        ..returns = refer('Widget')
        ..requiredParameters.add(Parameter(
          (p) => p
            ..name = 'context'
            ..type = refer('BuildContext'),
        ))
        ..body = Block((b) {
          if (beforeBuildReturn != null) {
            b.statements.addAll(beforeBuildReturn!);
          }
          b.statements.add(buildReturn.returned.statement);
        });
    });
  }

  @override
  List<Spec> toCode(bool showFull) {
    return [
      if (showFull)
        Class((c) {
          c
            ..name = 'SomeWidget'
            ..constructors.add(
              Constructor(
                (con) => con
                  ..constant = true
                  ..requiredParameters.add(Parameter(
                    (p) => p
                      ..name = 'key'
                      ..toSuper = true,
                  )),
              ),
            )
            ..extend = refer('StatelessWidget')
            ..methods.add(buildMethod());
        })
      else
        buildMethod(),
    ];
  }
}

class SomeWidget extends StatelessWidget {
  const SomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
