import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/utils/code_wrapper.dart';
import 'package:dreambook/src/utils/highlighter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_space.g.dart';

@Riverpod(keepAlive: true)
class ShowFullContent extends _$ShowFullContent {
  @override
  bool build() => false;

  void change(bool value) {
    state = value;
  }
}

class AutoCode extends ConsumerWidget {
  const AutoCode(
    this.name, {
    super.key,
    this.import = Imports.material,
    this.named = const {},
    this.typed = const [],
    this.positional = const [],
    this.initState = const [],
    this.dispose = const [],
  });
  final Imports import;
  final List<Code> initState;
  final List<Code> dispose;
  final String name;
  final List<Expression> positional;
  final Map<String, Expression> named;
  final List<Reference> typed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CodeSpace.from(CodeWrapper(
      name: name,
      import: import,
      namedArguments: named,
      typeArguments: typed,
      positionalArguments: positional,
      initState: initState,
      dispose: dispose,
      fullContent: ref.watch(showFullContentProvider),
    ).toCode());
  }
}

class CodeSpace extends ConsumerWidget {
  CodeSpace(List<String> codes, {super.key}) : code = codes.join('\n');
  const CodeSpace.from(this.code, {super.key});

  final String code;

  factory CodeSpace.wrapper(
    String name, {
    List<Code> initState = const [],
    List<Code> dispose = const [],
    Imports import = Imports.material,
    List<Expression> positioned = const [],
    Map<String, Expression> named = const <String, Expression>{},
    List<Reference> typed = const [],
  }) {
    return CodeSpace.from(CodeWrapper(
      name: name,
      import: import,
      namedArguments: named,
      typeArguments: typed,
      positionalArguments: positioned,
      initState: initState,
      dispose: dispose,
    ).toCode());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SelectableText.rich(
              CodeHighlight(context).highlight(code),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Row(
            children: [
              Switch(
                value: ref.watch(showFullContentProvider),
                onChanged: (t) {
                  ref.read(showFullContentProvider.notifier).change(t);
                },
              ),
              const Text('show all'),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                },
                icon: const Icon(
                  Icons.copy_rounded,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
