import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:dreambook/src/codes/imports.dart';
import 'package:dreambook/src/codes/widgets/stateful_widget.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/utils/highlighter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'code_space.dart';

class CodeArea extends ConsumerStatefulWidget {
  const CodeArea({
    super.key,
    this.api,
    this.imports,
    required this.codes,
  });
  final String? api;
  final List<Directive>? imports;
  final List<ToCode> codes;

  @override
  ConsumerState<CodeArea> createState() => _CodeAreaState();
}

class _CodeAreaState extends ConsumerState<CodeArea> {
  static final _emitter = DartEmitter();
  static final _formatter = DartFormatter();
  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).colorScheme.surface;
    final specs = [
      ...widget.imports ?? [Imports.material],
      for (final code in widget.codes)
        ...code.toCode(ref.watch(showFullContentProvider)),
    ];
    String code = specs.map((e) => e.accept(_emitter)).join('\n');
    code = _formatter.format(code);
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: SelectableText.rich(CodeHighlight(context).highlight(code)),
        ),
        Positioned(
          height: 48,
          top: 0,
          right: 0,
          left: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  background,
                  background.withOpacity(0),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.api != null)
                  IconButton(
                    onPressed: () async {
                      launchUrl(Uri(
                        scheme: 'https',
                        host: ref.read(apiBaseUrlProvider).$2,
                        path: widget.api,
                      ));
                    },
                    icon: const Icon(Icons.api_rounded),
                  ),
                IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: code));
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Copied!'),
                      action: SnackBarAction(
                        label: context.mtr.okButtonLabel,
                        onPressed: () {},
                      ),
                    ));
                  },
                  icon: const Icon(Icons.copy_rounded),
                ),
                Switch(
                  value: ref.watch(showFullContentProvider),
                  onChanged: (e) {
                    ref.read(showFullContentProvider.notifier).change(e);
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          height: 48,
          bottom: 0,
          right: 0,
          left: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  background.withOpacity(0),
                  background,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
