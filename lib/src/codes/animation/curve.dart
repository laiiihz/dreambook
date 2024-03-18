import 'package:code_builder/code_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension CurveCodeExt on Curve {
  Expression get $exp => switch (this) {
        Curves.bounceIn => refer('Curves.bounceIn'),
        Curves.bounceOut => refer('Curves.bounceOut'),
        Curves.bounceInOut => refer('Curves.bounceInOut'),
        Curves.decelerate => refer('Curves.decelerate'),
        Curves.ease => refer('Curves.ease'),
        Curves.easeIn => refer('Curves.easeIn'),
        Curves.easeInBack => refer('Curves.easeInBack'),
        Curves.easeInCirc => refer('Curves.easeInCirc'),
        Curves.easeInCubic => refer('Curves.easeInCubic'),
        Curves.easeInQuart => refer('Curves.easeInQuart'),
        Curves.easeInQuint => refer('Curves.easeInQuint'),
        Curves.easeInSine => refer('Curves.easeInSine'),
        Curves.easeInExpo => refer('Curves.easeInExpo'),
        Curves.easeInOut => refer('Curves.easeInOut'),
        Curves.easeInOutBack => refer('Curves.easeInOutBack'),
        Curves.easeInOutCirc => refer('Curves.easeInOutCirc'),
        Curves.easeInOutCubic => refer('Curves.easeInOutCubic'),
        Curves.easeInOutQuart => refer('Curves.easeInOutQuart'),
        Curves.easeInOutQuint => refer('Curves.easeInOutQuint'),
        Curves.easeInOutSine => refer('Curves.easeInOutSine'),
        Curves.easeInOutExpo => refer('Curves.easeInOutExpo'),
        Curves.easeOut => refer('Curves.easeOut'),
        Curves.easeOutBack => refer('Curves.easeOutBack'),
        Curves.easeOutCirc => refer('Curves.easeOutCirc'),
        Curves.easeOutCubic => refer('Curves.easeOutCubic'),
        Curves.easeOutQuart => refer('Curves.easeOutQuart'),
        Curves.easeOutQuint => refer('Curves.easeOutQuint'),
        Curves.easeOutSine => refer('Curves.easeOutSine'),
        Curves.easeOutExpo => refer('Curves.easeOutExpo'),
        Curves.linear => refer('Curves.linear'),
        Curves.fastOutSlowIn => refer('Curves.fastOutSlowIn'),
        Curves.elasticIn => refer('Curves.elasticIn'),
        Curves.elasticOut => refer('Curves.elasticOut'),
        Curves.elasticInOut => refer('Curves.elasticInOut'),
        _ => refer('null'),
      };
}
