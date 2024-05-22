import 'package:code_builder/code_builder.dart';
import 'package:flutter/widgets.dart';

extension BoxShapeX on BoxShape {
  Expression get $exp => refer('BoxShape').property(name);
}
