// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_builder/code_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';

part 'animated_icons.g.dart';

final animatedIconsItem = CodeItem(
  title: (context) => 'Animated Icons',
  code: const TheCode(),
  widget: const TheWidget(),
);

enum AnimatedIconsType {
  addEvent('add_event', AnimatedIcons.add_event),
  arrowMenu('arrow_menu', AnimatedIcons.arrow_menu),
  closeMenu('close_menu', AnimatedIcons.close_menu),
  ellipsisSearch('ellipsis_search', AnimatedIcons.ellipsis_search),
  eventAdd('event_add', AnimatedIcons.event_add),
  homeMenu('home_menu', AnimatedIcons.home_menu),
  listView('list_view', AnimatedIcons.list_view),
  menuArrow('menu_arrow', AnimatedIcons.menu_arrow),
  menuClose('menu_close', AnimatedIcons.menu_close),
  menuHome('menu_home', AnimatedIcons.menu_home),
  pausePlay('pause_play', AnimatedIcons.pause_play),
  playPause('play_pause', AnimatedIcons.play_pause),
  searchEllipsis('search_ellipsis', AnimatedIcons.search_ellipsis),
  viewList('view_list', AnimatedIcons.view_list),
  ;

  const AnimatedIconsType(this.rawName, this.data);

  final String rawName;
  final AnimatedIconData data;
}

class AnimatedIconsConfig {
  AnimatedIconsConfig({
    this.type = AnimatedIconsType.arrowMenu,
  });

  final AnimatedIconsType type;

  AnimatedIconsConfig copyWith({
    AnimatedIconsType? type,
  }) {
    return AnimatedIconsConfig(
      type: type ?? this.type,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  AnimatedIconsConfig build() => AnimatedIconsConfig();
  void change(AnimatedIconsConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return AutoCode(
      'Row',
      mixins: [refer('TickerProviderStateMixin')],
      fields: [
        Field(
          (f) => f
            ..name = 'controller'
            ..late = true
            ..modifier = FieldModifier.final$
            ..assignment = InvokeExpression.newOf(
                    refer('AnimationController'), [], {'vsync': refer('this')})
                .code,
        )
      ],
      named: {
        'children': literalList(
          [
            InvokeExpression.newOf(
              refer('AnimatedIcon'),
              [],
              {
                'icon': refer('AnimatedIcons.${config.type.rawName}'),
                'progress': refer('controller'),
                'size': literalNum(64),
              },
            ),
            const Code('const SizedBox(width: 8)'),
            const Code('''OutlinedButton(
            onPressed: () {
              controller.fling(velocity: forward ? 1 : -1);
              forward = !forward;
            },
            child: const Text('Switch'),
          )'''),
          ],
        ),
      },
    );
  }
}

class TheWidget extends ConsumerStatefulWidget {
  const TheWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TheWidgetState();
}

class _TheWidgetState extends ConsumerState<TheWidget>
    with TickerProviderStateMixin {
  late final controller = AnimationController(vsync: this);
  bool forward = true;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(configProvider);

    return WidgetWithConfiguration(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedIcon(
            icon: config.type.data,
            progress: controller,
            size: 64,
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: () {
              controller.fling(velocity: forward ? 1 : -1);
              forward = !forward;
            },
            child: const Text('Switch'),
          ),
        ],
      ),
      configs: [
        MenuTile(
          title: context.tr.theType,
          items: AnimatedIconsType.values,
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
