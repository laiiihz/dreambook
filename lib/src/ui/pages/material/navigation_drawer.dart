import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// part 'navigation_drawer.g.dart';

final drawerItem = CodeItem(
  title: (context) => context.tr.drawer,
  code: const TheCode(),
  widget: const TheWidget(),
);

// class DrawerConfig {}

// @riverpod
// class Config extends _$Config {
//   @override
//   DrawerConfig build() => DrawerConfig();
//   void change(DrawerConfig config) {
//     state = config;
//   }
// }

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AutoCode(
      'Drawer',
      apiUrl: '/flutter/material/Drawer-class.html',
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final config = ref.watch(configProvider);
    return const WidgetWithConfiguration(
      content: Drawer(),
      configs: [],
    );
  }
}
