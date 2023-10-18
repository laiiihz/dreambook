import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

// @override
// Widget build(BuildContext context) {
//   return;
// }

String test() {
  final content = InvokeExpression.newOf(
    CodeExpression(Code('Test')),
    [],
    {
      'good': CodeExpression(Code('\'code\'')),
      'good1': CodeExpression(Code('\'code\'')),
      'good2': CodeExpression(Code('\'code\'')),
      'good3': CodeExpression(Code('\'code\'')),
      'good4': CodeExpression(Code('\'code\'')),
    },
    [],
  );
  final aFun = Method((f) {
    f
      ..name = 'build'
      ..returns = const Reference('Widget')
      ..requiredParameters.add(Parameter((p) {
        p
          ..name = 'context'
          ..type = const Reference('BuildContext');
      }))
      ..body = Block((b) {
        b.addExpression(content.returned);
      })
      ..lambda = false
      ..annotations.add(CodeExpression(Code('override')));
  });

  return DartFormatter().format(aFun.accept(DartEmitter()).toString());
}

void main(List<String> args) {
  print(test());
}
