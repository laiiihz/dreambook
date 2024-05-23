// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/codes/widgets/widgets.dart';
import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_area.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'about.g.dart';

final aboutItem = CodeItem(
  title: (context) => 'About Widgets',
  code: const TheCode(),
  widget: const TheWidget(),
);

enum AboutType {
  listTile('AboutListTile'),
  dialog('AboutDialog'),
  licensePage('LicensePage'),
  ;

  const AboutType(this.rawName);

  final String rawName;
}

class AboutConfig {
  AboutConfig({this.type = AboutType.listTile});

  final AboutType type;

  AboutConfig copyWith({
    AboutType? type,
  }) {
    return AboutConfig(
      type: type ?? this.type,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  AboutConfig build() => AboutConfig();
  void change(AboutConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(Theme.of(context).primaryColor);
    final config = ref.watch(configProvider);
    // return AutoCode(config.type.rawName);
    return CodeArea(codes: [
      StatefulWidgetX(
        buildReturn: switch (config.type) {
          AboutType.listTile => refer('AboutListTile').call([]),
          AboutType.dialog => refer('AboutDialog').call([]),
          AboutType.licensePage => refer('LicensePage').call([]),
        },
      ),
    ]);
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      initialFractions: const [0.8, 0.2],
      content: switch (config.type) {
        AboutType.listTile => const AboutListTile(),
        AboutType.dialog => const AboutDialog(),
        AboutType.licensePage => const LicensePage(),
      },
      configs: [
        MenuTile(
          title: context.tr.theType,
          items: AboutType.values,
          current: config.type,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(type: t));
          },
          contentBuilder: (t) => t.name,
        ),
      ],
    );
  }
}
