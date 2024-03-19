import 'package:code_builder/code_builder.dart';
import 'package:flutter/rendering.dart';

extension StackFitCodeExt on StackFit {
  Expression get $exp => refer('StackFit').property(name);
}
