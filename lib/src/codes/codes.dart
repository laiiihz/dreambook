import 'package:code_builder/code_builder.dart';

class CodeType<T> {
  const CodeType.raw(this.expression);
  final Expression expression;

  Expression toCode() => expression;
}
