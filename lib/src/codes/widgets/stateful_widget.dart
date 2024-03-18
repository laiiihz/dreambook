import 'package:code_builder/code_builder.dart';

abstract class ToCode {
  List<Spec> toCode(bool showFull);
}

class StatefulWidgetX implements ToCode {
  StatefulWidgetX({
    this.initState,
    this.dispose,
    this.beforeBuildReturn,
    required this.buildReturn,
  });

  final List<Code>? initState;
  final List<Code>? dispose;
  final List<Code>? beforeBuildReturn;
  final Expression buildReturn;

  Class get baseClass {
    return Class((c) {
      c
        ..name = 'SomeWidget'
        ..extend = refer('StatefulWidget')
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
        ..methods.add(Method((m) {
          m
            ..name = 'createState'
            ..annotations.add(refer('override'))
            ..lambda = true
            ..returns = refer('State<SomeWidget>')
            ..body = InvokeExpression.newOf(refer('_SomeWidgetState'), []).code;
        }));
    });
  }

  Method buildInitState() {
    return Method((m) {
      m
        ..name = 'initState'
        ..returns = refer('void')
        ..annotations.add(refer('override'))
        ..body = Block((b) {
          b.statements
              .add(refer('super').newInstanceNamed('initState', []).statement);
          if (initState != null) b.statements.addAll(initState!);
        });
    });
  }

  Method buildDispose() {
    return Method((m) {
      m
        ..name = 'dispose'
        ..returns = refer('void')
        ..annotations.add(refer('override'))
        ..body = Block((b) {
          if (dispose != null) b.statements.addAll(dispose!);
          b.statements
              .add(refer('super').newInstanceNamed('dispose', []).statement);
        });
    });
  }

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
      if (showFull) baseClass,
      if (showFull)
        Class((c) {
          c
            ..name = '_SomeWidgetState'
            ..extend = refer('State<SomeWidget>')
            ..methods.addAll([
              if (initState != null) buildInitState(),
              if (dispose != null) buildDispose(),
              buildMethod(),
            ]);
        })
      else
        buildMethod(),
    ];
  }
}
