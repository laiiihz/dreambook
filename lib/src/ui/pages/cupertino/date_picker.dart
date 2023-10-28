// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_picker.g.dart';

final datePickerItem = CodeItem(
  title: 'Date Picker',
  code: const TheCode(),
  widget: const TheWidget(),
);

class DatePickerConfig {
  DatePickerConfig();
}

@riverpod
class Config extends _$Config {
  @override
  DatePickerConfig build() => DatePickerConfig();
  void change(DatePickerConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return const AutoCode('');
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: CupertinoDatePicker(
        onDateTimeChanged: (date) {},
      ),
      configs: [],
    );
  }
}
