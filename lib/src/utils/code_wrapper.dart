import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

class CodeWrapper {
  CodeWrapper({
    this.import = Imports.material,
    required this.name,
    this.namedArguments = const {},
    this.typeArguments = const [],
    this.positionalArguments = const [],
    this.initState = const [],
    this.dispose = const [],
    this.fullContent = false,
  });

  final Imports import;
  final List<Code> initState;
  final List<Code> dispose;
  final String name;
  final List<Expression> positionalArguments;
  final Map<String, Expression> namedArguments;
  final List<Reference> typeArguments;
  final bool fullContent;

  static final _formatter = DartFormatter();
  static final _emitter = DartEmitter();

  bool get hasInitState => initState.isNotEmpty;
  bool get hasDispose => dispose.isNotEmpty;

  String toCode() {
    final initStateFunction = Method.returnsVoid(
      (m) => m
        ..name = 'initState'
        ..annotations.add(refer('override'))
        ..body = Block((b) => b
          ..addExpression(refer('super.initState()'))
          ..statements.addAll(initState)),
    );

    final disposeFunction = Method.returnsVoid(
      (m) => m
        ..name = 'dispose'
        ..annotations.add(refer('override'))
        ..body = Block((b) => b
          ..statements.addAll(dispose)
          ..addExpression(refer('super.dispose()'))),
    );
    final buildFunction = Method(
      (m) => m
        ..name = 'build'
        ..returns = const Reference('Widget')
        ..annotations.add(refer('override'))
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'context'
              ..type = const Reference('BuildContext'),
          ),
        )
        ..body = Block((b) => b.addExpression(InvokeExpression.newOf(
              refer(name),
              positionalArguments,
              namedArguments,
              typeArguments,
            ).returned)),
    );

    List<Method> methods = [
      if (hasInitState) initStateFunction,
      if (hasDispose) disposeFunction,
      buildFunction,
    ];
    late final List<Spec> nextSpec;
    if (fullContent) {
      final clazzA = Class(
        (c) => c
          ..name = 'SomeWidget'
          ..extend = refer('StatefulWidget')
          ..constructors.add(
            Constructor(
              (c) => c
                ..constant = true
                ..optionalParameters.add(
                  Parameter((p) => p
                    ..name = 'key'
                    ..toSuper = true
                    ..named = true),
                ),
            ),
          )
          ..methods.add(
            Method((m) => m
              ..name = 'createState'
              ..lambda = true
              ..body = const Code('_SomeWidgetState()')
              ..returns = refer('State<SomeWidget>')),
          ),
      );

      // class _SomeWidgetState extends State<SomeWidget> {
      final clazzB = Class((c) => c
        ..name = '_SomeWidgetState'
        ..extend = refer('State<SomeWidget>')
        ..methods.addAll(methods));

      nextSpec = <Spec>[
        clazzA,
        clazzB,
      ];
    }
    return _formatter.format(
      <Spec>[
        import.directive,
        if (fullContent) ...nextSpec else ...methods,
      ].map((e) => e.accept(_emitter)).join('\n'),
    );
  }
}

enum Imports {
  material('package:flutter/material.dart'),
  cupertino('package:flutter/cupertino.dart'),
  painting('package:flutter/painting.dart'),
  ;

  const Imports(this.code);
  final String code;

  Directive get directive => Directive.import(code);
}
