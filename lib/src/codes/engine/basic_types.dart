import 'package:code_builder/code_builder.dart';
import 'package:flutter/rendering.dart';

extension AxisCodeExt on Axis {
  Expression get $exp => refer('Axis').property(name);
}
