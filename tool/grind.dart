import 'dart:io';

import 'package:grinder/grinder.dart';

main(args) => grind(args);

@Task('generate all g.dart files & l10n')
@Depends(l10n)
generate() async {
  await Dart.runAsync('run', arguments: ['build_runner', 'build']);
}

@Task('generate locale files')
l10n() async {
  await Process.run('flutter', ['gen-l10n']);
}

@Task()
clean() => defaultClean();
