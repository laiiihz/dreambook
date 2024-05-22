import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:animations/animations.dart';
import 'package:devtools_app_shared/ui.dart';
import 'package:dreambook/src/ui/widgets/about_button.dart';
import 'package:dreambook/src/ui/widgets/github_button.dart';
import 'package:dreambook/src/ui/widgets/theme_mode_button.dart';
import 'package:flutter/material.dart' hide Split;

class NamedCodeScaffold extends StatefulWidget {
  const NamedCodeScaffold({
    super.key,
    required this.title,
    required this.items,
    this.actions = const [],
  });
  final String title;
  final List<CodeItem> items;
  final List<Widget> actions;

  @override
  State<NamedCodeScaffold> createState() => NamedCodeScaffoldState();

  static NamedCodeScaffoldState of(BuildContext context) {
    return context.findAncestorStateOfType<NamedCodeScaffoldState>()!;
  }
}

class NamedCodeScaffoldState extends State<NamedCodeScaffold> {
  final index = ValueNotifier<int>(0);
  final scaffold = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final windowType = getBreakpointEntry(context).adaptiveWindowType;
    final bool hasDrawer = windowType < AdaptiveWindowType.medium;
    return Scaffold(
      key: scaffold,
      endDrawer: hasDrawer
          ? Drawer(
              child: WidgetList(
                widget.items,
                index: index,
                onTap: (value) {
                  index.value = value;
                },
              ),
            )
          : null,
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.title),
        actions: [
          ...widget.actions,
          const GithubButton(),
          const AboutButton(),
          const ThemeModeButton(),
          if (hasDrawer)
            IconButton(
              onPressed: () {
                scaffold.currentState!.openEndDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
        ],
      ),
      body: SharedCodeView(widget.items),
    );
  }
}

class SharedCodeView extends StatefulWidget {
  const SharedCodeView(this.items, {super.key});

  final List<CodeItem> items;

  @override
  State<SharedCodeView> createState() => _SharedCodeViewState();
}

class _SharedCodeViewState extends State<SharedCodeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  NamedCodeScaffoldState get parent => NamedCodeScaffold.of(context);

  @override
  Widget build(BuildContext context) {
    final windowType = getBreakpointEntry(context).adaptiveWindowType;
    final bool hasDrawer = windowType < AdaptiveWindowType.medium;

    final widgetList = WidgetList(
      widget.items,
      index: parent.index,
      onTap: (value) {
        parent.index.value = value;
      },
    );

    Widget content = ValueListenableBuilder<int>(
      valueListenable: parent.index,
      builder: (context, index, child) {
        final e = widget.items.elementAt(index);

        return PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
          child: AdaptiveSplitCodeView(
            code: e.code,
            widget: e.widget,
            key: ValueKey(e),
          ),
        );
      },
    );
    if (hasDrawer) {
      return content;
    } else {
      return Split(
        axis: Axis.horizontal,
        initialFractions: const [0.2, 0.8],
        children: [
          widgetList,
          content,
        ],
      );
    }
  }
}

class AdaptiveSplitCodeView extends StatefulWidget {
  const AdaptiveSplitCodeView(
      {super.key, required this.code, required this.widget});
  final Widget? code;
  final Widget widget;

  @override
  State<AdaptiveSplitCodeView> createState() => _AdaptiveSplitCodeViewState();
}

class _AdaptiveSplitCodeViewState extends State<AdaptiveSplitCodeView> {
  bool showCode = false;
  @override
  Widget build(BuildContext context) {
    if (widget.code == null) return widget.widget;
    final windowType = getBreakpointEntry(context).adaptiveWindowType;
    final bool isSmall = windowType < AdaptiveWindowType.small;
    return isSmall
        ? Stack(
            children: [
              PageTransitionSwitcher(
                reverse: showCode,
                transitionBuilder:
                    (child, primaryAnimation, secondaryAnimation) {
                  return SharedAxisTransition(
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    child: child,
                  );
                },
                child: showCode ? widget.code : widget.widget,
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: FloatingActionButton.small(
                  onPressed: () {
                    setState(() {
                      showCode = !showCode;
                    });
                  },
                  child: const Icon(Icons.code_rounded),
                ),
              ),
            ],
          )
        : Split(
            axis: Axis.horizontal,
            initialFractions: const [0.4, 0.6],
            children: [
              widget.widget,
              widget.code!,
            ],
          );
  }
}

class WidgetList extends StatefulWidget {
  const WidgetList(this.items,
      {super.key, required this.onTap, required this.index});
  final List<CodeItem> items;
  final ValueNotifier<int> index;
  final ValueChanged<int> onTap;

  @override
  State<WidgetList> createState() => _WidgetListState();
}

class _WidgetListState extends State<WidgetList> {
  void safeUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.index.addListener(safeUpdate);
  }

  @override
  void dispose() {
    widget.index.removeListener(safeUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = widget.items.elementAt(index);
        return ListTile(
          title: Text(item.title(context)),
          selected: widget.index.value == index,
          selectedTileColor: colorScheme.primaryContainer,
          selectedColor: colorScheme.onPrimaryContainer,
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.horizontal(
            right: Radius.circular(16),
          )),
          onTap: () => widget.onTap(index),
        );
      },
      itemCount: widget.items.length,
    );
  }
}

class CodeItem {
  final String Function(BuildContext context) title;
  final Widget? code;
  final Widget widget;

  CodeItem({
    required this.title,
    this.code,
    required this.widget,
  });
}

class WidgetWithConfiguration extends StatelessWidget {
  const WidgetWithConfiguration({
    super.key,
    required this.content,
    this.configs,
    this.initialFractions = const <double>[0.2, 0.8],
    this.axis = Axis.vertical,
    this.background = false,
  });
  final Widget content;

  /// * [SlidableTile]
  /// * [MenuTile]
  /// * [SwitchListTile]
  final List<Widget?>? configs;
  final List<double> initialFractions;
  final Axis axis;
  final bool background;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final top = Stack(
      children: [
        if (background) ...[
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: isDark
                      ? const AssetImage('assets/images/night.webp')
                      : const AssetImage('assets/images/seascape.webp'),
                ),
              ),
            ),
          ),
        ],
        Center(child: content),
      ],
    );

    if (configs != null && configs!.isNotEmpty) {
      return Split(
        axis: axis,
        initialFractions: initialFractions,
        children: [
          top,
          ListView(children: configs!.nonNulls.toList()),
        ],
      );
    } else {
      return top;
    }
  }
}
