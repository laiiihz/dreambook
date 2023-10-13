import 'package:dreambook/src/utils/highlighter.dart';
import 'package:flutter/material.dart';

class CodeSpace extends StatelessWidget {
  const CodeSpace(this.codes, {super.key});
  final List<String> codes;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SelectableText.rich(
          CodeHighlight(context).highlight(codes.join('\n')),
        ),
      ),
    );
  }
}
