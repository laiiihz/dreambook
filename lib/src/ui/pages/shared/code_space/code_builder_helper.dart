import 'package:code_builder/code_builder.dart';

class CodeHelper {
  static InvokeExpression setState([String? code]) {
    return InvokeExpression.newOf(refer('setState'), [
      Method(
        (m) => m
          ..body =
              code == null ? null : Block((b) => b.addExpression(refer(code))),
      ).closure
    ]);
  }
}
