import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_span.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cardItem = CodeItem(
  title: 'Card',
  code: const TheCode(),
  widget: const TheWidget(),
);

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CodeSpace(const [
      StaticCodes.material,
      '',
      'Card()',
    ]);
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const WidgetWithConfiguration(
      content: Card(
        margin: EdgeInsets.all(16),
        child: SizedBox.expand(),
      ),
      configs: [],
    );
  }
}
