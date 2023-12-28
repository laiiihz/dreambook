// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/slidable_tile.dart';
import 'package:dreambook/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'data_table.g.dart';

final dataTableItem = CodeItem(
  title: (context) => 'Data Table',
  code: const TheCode(),
  widget: const TheWidget(),
);

class DataTableConfig {
  DataTableConfig({
    this.showBottomBorder = false,
    this.dividerThickness = 1,
  });

  final bool showBottomBorder;
  final double dividerThickness;

  DataTableConfig copyWith({
    bool? showBottomBorder,
    double? dividerThickness,
  }) {
    return DataTableConfig(
      showBottomBorder: showBottomBorder ?? this.showBottomBorder,
      dividerThickness: dividerThickness ?? this.dividerThickness,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  DataTableConfig build() => DataTableConfig();
  void change(DataTableConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final thickness = config.dividerThickness.readableStr(0);
    return AutoCode(
      'DataTable',
      named: {
        'columns': literalList(List.generate(
            3, (index) => Code('DataColumn(label: Text(\'COL $index\'))'))),
        'row': literalList([
          InvokeExpression.newOf(refer('DataRow'), [], {
            'cells': literalList(List.generate(
                3, (index) => Code('DataCell(Text(\'CELL $index\'))'))),
          }),
        ]),
        if (config.showBottomBorder) 'showBottomBorder': literalTrue,
        'dividerThickness': refer(thickness),
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: DataTable(
        columns:
            List.generate(3, (index) => DataColumn(label: Text('COL $index'))),
        rows: [
          DataRow(
            cells: List.generate(
              3,
              (index) => DataCell(Text('CELL $index')),
            ),
          ),
        ],
        showBottomBorder: config.showBottomBorder,
        dividerThickness: config.dividerThickness,
      ),
      configs: [
        SwitchListTile(
          title: const Text('show bottom border'),
          value: config.showBottomBorder,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showBottomBorder: t));
          },
        ),
        SlidableTile(
          title: 'divider thickness',
          value: config.dividerThickness,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(dividerThickness: t));
          },
        ),
      ],
    );
  }
}
