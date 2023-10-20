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

  static Expression defineFinal(String name, String valueName,
      {String? subname}) {
    return declareFinal(name).assign(InvokeExpression.newOf(
      refer(valueName),
      [],
      {},
      [],
      subname,
    ));
  }
}
