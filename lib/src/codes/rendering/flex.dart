import 'package:code_builder/code_builder.dart';
import 'package:flutter/rendering.dart';

extension MainAxisAlignmentCodeExt on MainAxisAlignment {
  Expression get $exp => refer('MainAxisAlignment').property(name);
}

extension MainAxisSizeCodeExt on MainAxisSize {
  Expression get $exp => refer('MainAxisSize').property(name);
}

extension CrossAxisAlignmentCodeExt on CrossAxisAlignment {
  Expression get $exp => refer('CrossAxisAlignment').property(name);
}

extension VerticalDirectionCodeExt on VerticalDirection {
  Expression get $exp => refer('VerticalDirection').property(name);
}
