import 'package:code_builder/code_builder.dart';

class DurationX extends InvokeExpression {
  DurationX({
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
  }) : super.newOf(refer('Duration'), [], {
          if (days != 0) 'days': literalNum(days),
          if (hours != 0) 'hours': literalNum(hours),
          if (minutes != 0) 'minutes': literalNum(minutes),
          if (seconds != 0) 'seconds': literalNum(seconds),
          if (milliseconds != 0) 'milliseconds': literalNum(milliseconds),
          if (microseconds != 0) 'microseconds': literalNum(microseconds),
        });
}

extension DurationCodeExt on Duration {
  Expression get $exp {
    int micro = inMicroseconds;
    final days = micro ~/ Duration.microsecondsPerDay;
    final hours =
        micro % Duration.microsecondsPerDay ~/ Duration.microsecondsPerHour;
    final minutes =
        micro % Duration.microsecondsPerHour ~/ Duration.microsecondsPerMinute;
    final seconds = micro %
        Duration.microsecondsPerMinute ~/
        Duration.microsecondsPerSecond;
    final milliseconds = micro %
        Duration.microsecondsPerSecond ~/
        Duration.microsecondsPerMillisecond;
    final microseconds = micro % Duration.microsecondsPerMillisecond;
    return InvokeExpression.newOf(refer('Duration'), [], {
      if (days != 0) 'days': literalNum(days),
      if (hours != 0) 'hours': literalNum(hours),
      if (minutes != 0) 'minutes': literalNum(minutes),
      if (seconds != 0) 'seconds': literalNum(seconds),
      if (milliseconds != 0) 'milliseconds': literalNum(milliseconds),
      if (microseconds != 0) 'microseconds': literalNum(microseconds),
    });
  }
}
