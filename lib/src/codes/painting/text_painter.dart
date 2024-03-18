import 'package:code_builder/code_builder.dart';
import 'package:flutter/painting.dart';

extension TextOverflowCodeExt on TextOverflow {
  Expression get toCode => switch (this) {
        TextOverflow.clip => refer('TextOverflow.clip'),
        TextOverflow.fade => refer('TextOverflow.fade'),
        TextOverflow.ellipsis => refer('TextOverflow.ellipsis'),
        TextOverflow.visible => refer('TextOverflow.visible'),
      };
}
