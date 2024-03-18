import 'dart:ui';

import 'package:code_builder/code_builder.dart';

extension FontWeightCodeExt on FontWeight {
  Expression get $exp => switch (this) {
        FontWeight.bold => refer('FontWeight.bold'),
        FontWeight.normal => refer('FontWeight.normal'),
        _ => refer('FontWeiht.w$value'),
      };

  String get name => switch (this) {
        FontWeight.bold => 'bold',
        FontWeight.normal => 'normal',
        _ => 'w$value',
      };
}

extension FontStyleCodeExt on FontStyle {
  Expression get $exp => refer('FontStyle').property(name);
}

extension TextBaselineCodeExt on TextBaseline {
  Expression get $exp => refer('TextBaseline').property(name);
}

extension TextLeadingDistributionCodeExt on TextLeadingDistribution {
  Expression get $exp => refer('TextLeadingDistribution').property(name);
}

extension TextAlignCodeExt on TextAlign {
  Expression get toCode => refer('TextAlign').property(name);
}

extension TextDirectionCodeExt on TextDirection {
  Expression get $exp => refer('TextDirection').property(name);
}
