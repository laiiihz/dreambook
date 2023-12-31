import 'package:dreambook/src/ui/app.dart';
import 'package:dreambook/src/utils/highlighter.dart';
import 'package:dreambook/src/utils/kv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CodeHighlight.ensureInitialized();
  await KV.ensureInitialized();
  runApp(const ProviderScope(child: App()));
}
