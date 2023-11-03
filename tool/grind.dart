import 'package:grinder/grinder.dart';

main(args) => grind(args);

@Task()
generate() async {
  await Dart.runAsync('build_runner', arguments: ['build']);
}

@Task()
clean() => defaultClean();
