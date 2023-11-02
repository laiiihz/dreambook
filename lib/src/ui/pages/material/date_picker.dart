// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_builder_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_picker.g.dart';

final datePickerItem = CodeItem(
  title: (context) => context.tr.datePicker,
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

  String get apiUrl => '/flutter/material/$code.html';
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
    return AutoCode(
      'FilledButton.icon',
      apiUrl: config.type.apiUrl,
      fields: switch (config.type) {
        DatePickerType.date => [
            Field((f) => f
              ..name = 'current'
              ..type = refer('DateTime?'))
          ],
        DatePickerType.time => [
            Field((f) => f
              ..name = 'current'
              ..type = refer('TimeOfDay?'))
          ],
        DatePickerType.range => [
            Field((f) => f
              ..name = 'current'
              ..type = refer('DateTimeRange?'))
          ],
      },
      named: {
        'onPressed': Method((m) => m
          ..modifier = MethodModifier.async
          ..body = Block((b) {
            b.addExpression(
                CodeHelper.defineFinal('current', 'DateTime', subname: 'now'));
            b.addExpression(declareFinal('start').assign(InvokeExpression.newOf(
                refer('current'),
                [refer('const Duration(days: 720)')],
                {},
                [],
                'subtract')));
            b.addExpression(declareFinal('end').assign(InvokeExpression.newOf(
                refer('current'),
                [refer('const Duration(days: 720)')],
                {},
                [],
                'add')));

            switch (config.type) {
              case DatePickerType.date:
                b.addExpression(
                    declareFinal('date').assign(InvokeExpression.newOf(
                  refer('showPicker'),
                  [],
                  {
                    'context': refer('ccontext'),
                    'initialDate': refer('current'),
                    'firstDate': refer('start'),
                    'lastDate': refer('end'),
                    if (config.dateMode != DatePickerMode.day)
                      'initialDatePickerMode':
                          refer('DatePickerMode.${config.dateMode.name}'),
                    if (config.dateEntryMode != DatePickerEntryMode.calendar)
                      'initialEntryMode': refer(
                          'DatePickerEntryMode.${config.dateEntryMode.name}'),
                  },
                ).awaited));
                b.addExpression(
                    refer('if(date != null){setState(() {current = date;});}'));
              case DatePickerType.time:
                b.addExpression(
                    declareFinal('time').assign(InvokeExpression.newOf(
                  refer('showPicker'),
                  [],
                  {
                    'context': refer('context'),
                    'initialTime': refer('current'),
                    if (config.timeEntryMode != TimePickerEntryMode.dial)
                      'initialEntryMode':
                          refer('TimePickerEntryMode.${config.timeEntryMode}'),
                  },
                ).awaited));
                b.addExpression(
                    refer('if(time != null){setState(() {current = time;});}'));
              case DatePickerType.range:
                b.addExpression(
                    declareFinal('range').assign(InvokeExpression.newOf(
                  refer('showPicker'),
                  [],
                  {
                    'context': refer('context'),
                    'initialDateRange': refer('current'),
                    'firstDate': refer('start'),
                    'lastDate': refer('end'),
                    if (config.dateEntryMode != DatePickerEntryMode.calendar)
                      'initialEntryMode': refer(
                          'DatePickerEntryMode.${config.dateEntryMode.name}'),
                  },
                ).awaited));
                b.addExpression(refer(
                    'if(range != null){setState(() {current = range;});}'));
            }
          })).closure,
        'icon': refer('const Icon(Icons.date_range)'),
        'label': refer("const Text('show ${config.type.name} Picker')"),
      },
    );
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
          title: context.tr.theType,
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
