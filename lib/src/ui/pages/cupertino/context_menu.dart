// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contextMenuItem = CodeItem(
  title: (context) => context.tr.contextMenu,
  code: const TheCode(),
  widget: const TheWidget(),
);

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoCode(
      'CupertinoContextMenu.builder',
      apiUrl: '/flutter/cupertino/CupertinoContextMenu-class.html',
      named: {
        'actions': refer('''[
          CupertinoContextMenuAction(
            child: const Text('Action A'),
            onPressed: () {},
          ),
        ]'''),
        'builder': refer('''(context, animation) {
          return const FlutterLogo(size: 128);
        }'''),
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WidgetWithConfiguration(
      content: CupertinoContextMenu.builder(
        actions: [
          CupertinoContextMenuAction(
            child: const Text('Action A'),
            onPressed: () {},
          ),
        ],
        builder: (context, animation) {
          return const FlutterLogo(size: 128);
        },
      ),
      configs: const [],
    );
  }
}
