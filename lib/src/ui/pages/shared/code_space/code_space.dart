import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/utils/code_wrapper.dart';
import 'package:dreambook/src/utils/highlighter.dart';
import 'package:dreambook/src/utils/kv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_space.g.dart';

@Riverpod(keepAlive: true)
class ShowFullContent extends _$ShowFullContent {
  @override
  bool build() => KV.showAllCode;

  void change(bool value) {
    state = value;
    KV.showAllCode = value;
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
    this.fields = const [],
    this.prefix = const [],
  });
  final Imports import;
  final List<Code> initState;
  final List<Code> dispose;
  final String name;
  final List<Expression> positional;
  final Map<String, Expression> named;
  final List<Reference> typed;
  final List<Field> fields;
  final List<Spec> prefix;

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
      middle: fields,
      custom: prefix,
      fullContent: ref.watch(showFullContentProvider),
    ).toCode());
  }
}

class CodeSpace extends ConsumerStatefulWidget {
  CodeSpace(List<String> codes, {super.key}) : code = codes.join('\n');
  const CodeSpace.from(this.code, {super.key});

  final String code;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CodeSpaceState();
}

class _CodeSpaceState extends ConsumerState<CodeSpace> {
  final _controller = ScrollController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SizedBox.expand(
          child: SingleChildScrollView(
            controller: _controller,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
            child: SelectableText.rich(
              CodeHighlight(context).highlight(widget.code),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Row(
            children: [
              Tooltip(
                message: context.tr.showAll,
                child: Switch(
                  value: ref.watch(showFullContentProvider),
                  onChanged: (t) {
                    ref.read(showFullContentProvider.notifier).change(t);
                  },
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: widget.code));
                },
                tooltip: context.mtr.copyButtonLabel,
                icon: const Icon(Icons.copy_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
