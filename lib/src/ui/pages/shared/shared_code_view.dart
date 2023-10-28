import 'package:animations/animations.dart';
import 'package:devtools_app_shared/ui.dart';
import 'package:dreambook/src/ui/widgets/about_button.dart';
import 'package:dreambook/src/ui/widgets/github_button.dart';
import 'package:dreambook/src/ui/widgets/theme_mode_button.dart';
import 'package:flutter/material.dart';

class NamedCodeScaffold extends StatelessWidget {
  const NamedCodeScaffold(
      {super.key, required this.title, required this.items});
  final String title;
  final List<CodeItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(title),
        actions: const [
          GithubButton(),
          AboutButton(),
          ThemeModeButton(),
        ],
      ),
      body: SharedCodeView(items),
    );
  }
}

class SharedCodeView extends StatefulWidget {
  const SharedCodeView(this.items, {super.key});

  final List<CodeItem> items;

  @override
  State<SharedCodeView> createState() => _SharedCodeViewState();
}

class _SharedCodeViewState extends State<SharedCodeView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _index = ValueNotifier<int>(0);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.items.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Split(
      axis: Axis.horizontal,
      initialFractions: const [0.2, 0.8],
      children: [
        WidgetList(
          widget.items,
          index: _index,
          onTap: (value) {
            _index.value = value;
            _tabController.animateTo(value);
          },
        ),
        ValueListenableBuilder<int>(
          valueListenable: _index,
          builder: (context, index, child) {
            final e = widget.items.elementAt(index);
            final child = Split(
              key: ValueKey(e),
              axis: Axis.horizontal,
              initialFractions: const [0.4, 0.6],
              children: [
                e.widget,
                e.code,
              ],
            );

            return PageTransitionSwitcher(
              transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.vertical,
                  child: child,
                );
              },
              child: child,
            );
          },
        ),
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
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = widget.items.elementAt(index);
        return ListTile(
          title: Text(item.title),
          selected: widget.index.value == index,
          onTap: () => widget.onTap(index),
        );
      },
      itemCount: widget.items.length,
    );
  }
}

class CodeItem {
  final String title;
  final Widget code;
  final Widget widget;

  CodeItem({
    required this.title,
    required this.code,
    required this.widget,
  });
}

class WidgetWithConfiguration extends StatelessWidget {
  const WidgetWithConfiguration({
    super.key,
    required this.content,
    required this.configs,
    this.initialFractions = const <double>[0.2, 0.8],
    this.axis = Axis.vertical,
    this.background = false,
  });
  final Widget content;
  final List<Widget> configs;
  final List<double> initialFractions;
  final Axis axis;
  final bool background;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Split(
      axis: axis,
      initialFractions: initialFractions,
      children: [
        Stack(
          children: [
            if (background) ...[
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      // https://unsplash.com/photos/ocean-view-during-daytime-XJfHMPJ0e-g?utm_content=creditShareLink&utm_medium=referral&utm_source=unsplash
                      // https://unsplash.com/photos/blue-starry-night-sky-NORa8-4ohA0?utm_content=creditShareLink&utm_medium=referral&utm_source=unsplash
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
        ),
        ListView(children: configs),
      ],
    );
  }
}
