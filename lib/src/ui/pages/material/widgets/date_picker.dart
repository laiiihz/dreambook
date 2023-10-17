// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_span.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';

part 'date_picker.g.dart';

final datePickerItem = CodeItem(
  title: 'Date Picker',
  code: const TheCode(),
  widget: const TheWidget(),
);

enum DatePickerType {
  date('showDatePicker'),
  time('showTimePicker'),
  range('showDateRangePicker'),
  ;

  const DatePickerType(this.code);
  final String code;
}

class DatePickerConfig {
  DatePickerConfig({
    this.type = DatePickerType.date,
    this.dateMode = DatePickerMode.day,
    this.dateEntryMode = DatePickerEntryMode.calendar,
    this.timeEntryMode = TimePickerEntryMode.dial,
  });

  final DatePickerType type;
  final DatePickerMode dateMode;
  final DatePickerEntryMode dateEntryMode;
  final TimePickerEntryMode timeEntryMode;

  DatePickerConfig copyWith({
    bool? hasInitial,
    DatePickerType? type,
    DatePickerMode? dateMode,
    DatePickerEntryMode? dateEntryMode,
    TimePickerEntryMode? timeEntryMode,
  }) {
    return DatePickerConfig(
      type: type ?? this.type,
      dateMode: dateMode ?? this.dateMode,
      dateEntryMode: dateEntryMode ?? this.dateEntryMode,
      timeEntryMode: timeEntryMode ?? this.timeEntryMode,
    );
  }
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
    return CodeSpace([
      StaticCodes.material,
      '',
      if (config.type != DatePickerType.time) ...[
        'final now = DateTime.now();',
        'DateTime start = now.subtract(const Duration(days: 720));',
        'DateTime end = now.add(const Duration(days: 720));',
      ],
      ...switch (config.type) {
        DatePickerType.range => ['DateTimeRange? range = null;'],
        DatePickerType.date => ['DateTime current = now;'],
        DatePickerType.time => ['TimeOfDay current = TimeOfDay.now();'],
      },
      '',
      'showPicker() async {',
      '  context: context,',
      '  final result = await ${config.type.code}(',
      if (config.type == DatePickerType.range) '  initialDateRange: range,',
      switch (config.type) {
        DatePickerType.date => '  initialDate: current,',
        DatePickerType.time => '  initialTime: current,',
        DatePickerType.range => '  initialDateRange: range,',
      },
      if (config.type == DatePickerType.date &&
          config.dateMode != DatePickerMode.day)
        '  initialDatePickerMode: DatePickerMode.${config.dateMode},',
      if (config.type != DatePickerType.time) ...[
        '  first: start,',
        '  last: end,',
        if (config.dateEntryMode != DatePickerEntryMode.calendar)
          '  initialEntryMode: DatePickerEntryMode.${config.dateEntryMode.name},',
      ],
      if (config.type == DatePickerType.time &&
          config.timeEntryMode != TimePickerEntryMode.dial)
        '  initialEntryMode: TimePickerEntryMode.${config.timeEntryMode.name},',
      '  );',
      '}',
    ]);
  }
}

@riverpod
class InitDate extends _$InitDate {
  @override
  DateTime build() => DateTime.now();

  change(DateTime date) {
    state = date;
  }
}

@riverpod
class InitDateRange extends _$InitDateRange {
  @override
  DateTimeRange? build() => null;

  change(DateTimeRange range) {
    state = range;
  }
}

@riverpod
class InitTime extends _$InitTime {
  @override
  TimeOfDay build() => TimeOfDay.now();

  change(TimeOfDay time) {
    state = time;
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final initDate = ref.watch(initDateProvider);
    final initRange = ref.watch(initDateRangeProvider);
    final initTime = ref.watch(initTimeProvider);
    return WidgetWithConfiguration(
      content: FilledButton.icon(
        onPressed: () async {
          final current = DateTime.now();
          final first = current.subtract(const Duration(days: 720));
          final last = current.add(const Duration(days: 720));
          switch (config.type) {
            case DatePickerType.date:
              final date = await showDatePicker(
                context: context,
                initialDate: initDate,
                firstDate: first,
                lastDate: last,
                initialDatePickerMode: config.dateMode,
                initialEntryMode: config.dateEntryMode,
              );
              if (date != null) {
                ref.read(initDateProvider.notifier).change(date);
              }
            case DatePickerType.time:
              if (!context.mounted) return;
              final time = await showTimePicker(
                context: context,
                initialTime: initTime,
                initialEntryMode: config.timeEntryMode,
              );
              if (time != null) {
                ref.read(initTimeProvider.notifier).change(time);
              }
            case DatePickerType.range:
              if (!context.mounted) return;

              final dateRange = await showDateRangePicker(
                context: context,
                initialEntryMode: config.dateEntryMode,
                initialDateRange: initRange,
                firstDate: first,
                lastDate: last,
              );
              if (dateRange != null) {
                ref.read(initDateRangeProvider.notifier).change(dateRange);
              }
          }
        },
        icon: const Icon(Icons.date_range),
        label: Text('show ${config.type.name} Picker'),
      ),
      configs: [
        MenuTile(
          title: 'type',
          items: DatePickerType.values,
          current: config.type,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(type: t));
          },
          contentBuilder: (t) => t.name,
        ),
        if (config.type == DatePickerType.date)
          MenuTile(
            title: 'Date Picker Mode',
            items: DatePickerMode.values,
            current: config.dateMode,
            onTap: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(dateMode: t));
            },
            contentBuilder: (t) => t.name,
          ),
        if (config.type == DatePickerType.time)
          MenuTile(
            title: 'Time Entry Mode',
            items: TimePickerEntryMode.values,
            current: config.timeEntryMode,
            onTap: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(timeEntryMode: t));
            },
            contentBuilder: (t) => t.name,
          ),
        if (config.type != DatePickerType.time)
          MenuTile(
            title: 'Date Entry Mode',
            items: DatePickerEntryMode.values,
            current: config.dateEntryMode,
            onTap: (t) {
              ref
                  .read(configProvider.notifier)
                  .change(config.copyWith(dateEntryMode: t));
            },
            contentBuilder: (t) => t.name,
          )
      ],
    );
  }
}
