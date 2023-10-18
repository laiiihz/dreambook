import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_span.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CodeSpace(const [
      StaticCodes.material,
      '',
      'int currentIndex = 0;',
      '''NavigationBar(
  selectedIndex: currentIndex,
  onDestinationSelected: (value) {
    setState(() {
      currentIndex = value;
    });
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
)
''',
    ]);
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
