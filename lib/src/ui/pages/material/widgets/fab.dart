// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dreambook/src/ui/pages/shared/code_space/code_space.dart';
import 'package:dreambook/src/ui/pages/shared/code_space/code_span.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/shared/tiles/menu_tile.dart';

part 'fab.g.dart';

final fabItem = CodeItem(
  title: 'FAB',
  code: const TheCode(),
  widget: const TheWidget(),
);

enum FabType {
  normal('FloatingActionButton'),
  large('FloatingActionButton.large'),
  small('FloatingActionButton.small'),
  extended('FloatingActionButton.extended'),
  ;

  const FabType(this.contentName);
  final String contentName;
}

enum FabLocation {
  startTop(FloatingActionButtonLocation.startTop),
  miniStartTop(FloatingActionButtonLocation.miniStartTop),
  centerTop(FloatingActionButtonLocation.centerTop),
  miniCenterTop(FloatingActionButtonLocation.miniCenterTop),
  endTop(FloatingActionButtonLocation.endTop),
  miniEndTop(FloatingActionButtonLocation.miniEndTop),
  startFloat(FloatingActionButtonLocation.startFloat),
  miniStartFloat(FloatingActionButtonLocation.miniStartFloat),
  centerFloat(FloatingActionButtonLocation.centerFloat),
  miniCenterFloat(FloatingActionButtonLocation.miniCenterFloat),
  endFloat(FloatingActionButtonLocation.endFloat),
  miniEndFloat(FloatingActionButtonLocation.miniEndFloat),
  startDocked(FloatingActionButtonLocation.startDocked),
  miniStartDocked(FloatingActionButtonLocation.miniStartDocked),
  centerDocked(FloatingActionButtonLocation.centerDocked),
  miniCenterDocked(FloatingActionButtonLocation.miniCenterDocked),
  endDocked(FloatingActionButtonLocation.endDocked),
  miniEndDocked(FloatingActionButtonLocation.miniEndDocked),
  endContained(FloatingActionButtonLocation.endContained),
  ;

  const FabLocation(this.rawType);

  final FloatingActionButtonLocation rawType;
}

enum MaterialShapeDefined {
  unset('null'),
  circle('const CircleBorder()'),
  stadium('const StadiumBorder()'),
  rectangle('RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))'),
  continuous(
      'ContinuousRectangleBorder(borderRadius: BorderRadius.circular(48))'),
  star(
      'const StarBorder(points: 8,innerRadiusRatio: 0.8,pointRounding: 0.4,valleyRounding: 0.4)'),
  ;

  const MaterialShapeDefined(this.code);
  final String code;

  ShapeBorder? get shape {
    switch (this) {
      case MaterialShapeDefined.unset:
        return null;
      case MaterialShapeDefined.circle:
        return const CircleBorder();
      case MaterialShapeDefined.stadium:
        return const StadiumBorder();
      case MaterialShapeDefined.rectangle:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        );
      case MaterialShapeDefined.continuous:
        return ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        );
      case MaterialShapeDefined.star:
        return const StarBorder(
          points: 8,
          innerRadiusRatio: 0.8,
          pointRounding: 0.4,
          valleyRounding: 0.4,
        );
    }
  }
}

class FabConfig {
  FabConfig({
    this.enabled = true,
    this.type = FabType.normal,
    this.shape = MaterialShapeDefined.unset,
    this.location = FabLocation.endFloat,
  });

  final bool enabled;
  final FabType type;
  final MaterialShapeDefined shape;
  final FabLocation location;

  FabConfig copyWith({
    bool? enabled,
    FabType? type,
    MaterialShapeDefined? shape,
    FabLocation? location,
  }) {
    return FabConfig(
      enabled: enabled ?? this.enabled,
      type: type ?? this.type,
      shape: shape ?? this.shape,
      location: location ?? this.location,
    );
  }
}

@riverpod
class Config extends _$Config {
  @override
  FabConfig build() => FabConfig();

  void change(FabConfig config) {
    state = config;
  }
}

class TheCode extends ConsumerWidget {
  const TheCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return CodeSpace([
      StaticCodes.material,
      '',
      'Scaffold(',
      if (config.location != FabLocation.endFloat)
        '  floatingActionButtonLocation: FloatingActionButtonLocation.${config.location.name},',
      '  floatingActionButton: ${config.type.contentName}(',
      config.enabled ? '    onPressed: () {},' : '  onPressed: null,',
      config.type == FabType.extended
          ? '    icon: const Icon(Icons.add),'
          : '    child: const Icon(Icons.add),',
      if (config.type == FabType.extended) "    label: const Text('Extended')",
      if (config.shape != MaterialShapeDefined.unset)
        '    shape: ${config.shape.code},',
      '  ),',
      ')',
    ]);
  }
}

class TheWidget extends ConsumerWidget {
  const TheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    return WidgetWithConfiguration(
      initialFractions: const [0.5, 0.5],
      content: const TheFab(),
      configs: [
        MenuTile<FabType>(
          title: 'Type',
          items: FabType.values,
          current: config.type,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(type: t));
          },
          contentBuilder: (t) => t.name,
        ),
        MenuTile<MaterialShapeDefined>(
          title: 'Shape',
          items: MaterialShapeDefined.values,
          current: config.shape,
          onTap: (t) {
            ref.read(configProvider.notifier).change(config.copyWith(shape: t));
          },
          contentBuilder: (t) => t.name,
        ),
        SwitchListTile(
          title: const Text('Enabled'),
          value: config.enabled,
          onChanged: (state) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(enabled: state));
          },
        ),
        MenuTile(
          title: 'location',
          items: FabLocation.values,
          current: config.location,
          onTap: (t) {
            ref
                .read(configProvider.notifier)
                .change(config.copyWith(location: t));
          },
          contentBuilder: (t) => t.name,
        ),
      ],
    );
  }
}

class TheFab extends ConsumerWidget {
  const TheFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final VoidCallback? onPressed = config.enabled ? () {} : null;
    final shape = config.shape.shape;
    const icon = Icon(Icons.add);
    late Widget fab;
    switch (config.type) {
      case FabType.normal:
        fab = FloatingActionButton(
            onPressed: onPressed, shape: shape, child: icon);
      case FabType.large:
        fab = FloatingActionButton.large(
            onPressed: onPressed, shape: shape, child: icon);
      case FabType.small:
        fab = FloatingActionButton.small(
            onPressed: onPressed, shape: shape, child: icon);
      case FabType.extended:
        fab = FloatingActionButton.extended(
          onPressed: onPressed,
          icon: icon,
          shape: shape,
          label: const Text('extended'),
        );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      bottomNavigationBar: const BottomAppBar(),
      floatingActionButton: fab,
      floatingActionButtonLocation: config.location.rawType,
    );
  }
}
