// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';

part 'container.g.dart';

final containerItem = CodeItem(
  title: (context) => context.tr.container,
  code: const TheCode(),
  widget: const TheWidget(),
);

class ContainerConfig {
  ContainerConfig({
    this.width,
    this.height,
  });

  final double? width;
  final double? height;
}

@riverpod
class Config extends _$Config {
  @override
  ContainerConfig build() => ContainerConfig();
  void change(ContainerConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return const AutoCode(
      'Container',
      apiUrl: '/flutter/widgets/Container-class.html',
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      content: Container(),
      configs: const [],
    );
  }
}
