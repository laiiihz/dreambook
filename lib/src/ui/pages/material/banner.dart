// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'banner.g.dart';

final bannerItem = CodeItem(
  title: (context) => 'Banner',
  code: const TheCode(),
  widget: const TheWidget(),
);

class BannerConfig {
  BannerConfig({
    this.showLeading = false,
    this.forceActionsBelow = false,
  });

  final bool showLeading;
  final bool forceActionsBelow;

  BannerConfig copyWith({
    bool? showLeading,
    bool? forceActionsBelow,
  }) {
    return BannerConfig(
      showLeading: showLeading ?? this.showLeading,
      forceActionsBelow: forceActionsBelow ?? this.forceActionsBelow,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  BannerConfig build() => BannerConfig();
  void change(BannerConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'Column',
      buildExpressions: [
        declareFinal('banner')
            .assign(InvokeExpression.newOf(refer('MaterialBanner'), [], {
          'content':
              InvokeExpression.newOf(refer('Text'), [literalString('content')]),
          if (config.showLeading)
            'leading': refer('const Icon(Icons.flutter_dash)'),
          if (config.forceActionsBelow) 'forceActionsBelow': literalTrue,
          'actions': literalList(
            [
              InvokeExpression.newOf(refer('TextButton'), [], {
                'onPressed': Method((m) => m.body = Block()).closure,
                'child': InvokeExpression.constOf(
                    refer('Text'), [literalString('action')]),
              })
            ],
          ),
        })),
      ],
      named: {
        'children': literalList([
          refer('banner'),
          InvokeExpression.newOf(refer('TextButton'), [], {
            'onPressed': Method((m) => m.body = Block((b) {
                  b.addExpression(const CodeExpression(Code(
                      'ScaffoldMessenger.of(context).clearMaterialBanners()')));
                  b.addExpression(const CodeExpression(Code(
                      'ScaffoldMessenger.of(context).showMaterialBanner(banner)')));
                })).closure,
            'child': InvokeExpression.constOf(
                refer('Text'), [literalString('Show Banner')]),
          }),
        ]),
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final banner = MaterialBanner(
      leading: config.showLeading ? const Icon(Icons.flutter_dash) : null,
      content: const Text('Content'),
      forceActionsBelow: config.forceActionsBelow,
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text('Action'),
        )
      ],
    );
    return WidgetWithConfiguration(
      initialFractions: const [0.5, 0.5],
      content: Column(
        children: [
          banner,
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).clearMaterialBanners();
              ScaffoldMessenger.of(context).showMaterialBanner(banner);
            },
            child: const Text('Show Banner'),
          ),
        ],
      ),
      configs: [
        SwitchListTile(
          title: const Text('show leading'),
          value: config.showLeading,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(showLeading: t));
          },
        ),
        SwitchListTile(
          title: const Text('force actions below'),
          value: config.forceActionsBelow,
          onChanged: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(forceActionsBelow: t));
          },
        ),
        //forceActionsBelow
      ],
    );
  }
}
