import 'package:flutter/material.dart';

extension DoubleExt on double {
  String readableStr([int fractionDigits = 1]) {
    final content = toStringAsFixed(fractionDigits);
    final dotIndex = content.indexOf('.');
    if (dotIndex == -1) {
      return content;
    }
    final chars = content.characters.toList();
    while (chars.last == '0' && chars.last != '.') {
      chars.removeLast();
    }
    final result = chars.join('');
    if (result.endsWith('.')) return result.substring(0, result.indexOf('.'));
    return result;
  }
}
