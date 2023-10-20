import 'package:code_builder/code_builder.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_builder_helper.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_bar.g.dart';

final navigationBarItem = CodeItem(
  title: 'Navigation Bar',
  code: const TheCode(),
  widget: const TheWidget(),
);

class NavigationBarConfig {}

@riverpod
class Config extends _$Config {
  @override
  NavigationBarConfig build() => NavigationBarConfig();
  void change(NavigationBarConfig config) {
    state = config;
  }
}

@riverpod
class CurrentIndex extends _$CurrentIndex {
  @override
  int build() => 0;

  void change(int value) => state = value;
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  InvokeExpression genNaviItem(String title, String icon, String selectIcon) {
    return InvokeExpression.newOf(
      refer('NavigationDestination'),
      [],
      {
        'icon': refer('Icon(Icons.$icon)'),
        'selectedIcon': refer('Icon(Icons.$selectIcon)'),
        'label': refer("'$title'"),
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoCode(
      'NavigationBar',
      custom: [
        Field((f) => f
          ..name = 'currentIndex'
          ..assignment = const Code('0')),
      ],
      named: {
        'selectedIndex': refer('currentIndex'),
        'onDestinationSelected': Method((m) => m
          ..body = Block((b) => b.addExpression(
                CodeHelper.setState('currentIndex = value'),
              ))).closure,
        'destinations': literalConstList(
          [
            genNaviItem('Home', 'home', 'home_outlined'),
            genNaviItem('Favorite', 'favorite', 'favorite_outline'),
            genNaviItem('Profile', 'person', 'person_outlined'),
          ],
        ),
      },
    );
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WidgetWithConfiguration(
      content: NavigationBar(
        selectedIndex: ref.watch(currentIndexProvider),
        onDestinationSelected: (value) {
          ref.read(currentIndexProvider.notifier).change(value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      configs: const [],
    );
  }
}
