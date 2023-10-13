import 'package:flutter/material.dart';

class MenuTile<T> extends StatelessWidget {
  const MenuTile({
    super.key,
    required this.title,
    required this.items,
    required this.current,
    required this.onTap,
    required this.contentBuilder,
  });
  final String title;
  final List<T> items;
  final T current;
  final ValueChanged<T> onTap;
  final String Function(T) contentBuilder;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Builder(builder: (context) {
        return ActionChip(
          label: Text(contentBuilder(current)),
          onPressed: () {
            showPopMenu(context);
          },
        );
      }),
    );
  }

  showPopMenu(BuildContext context) async {
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final PopupMenuPosition popupMenuPosition =
        popupMenuTheme.position ?? PopupMenuPosition.over;
    late Offset offset;
    switch (popupMenuPosition) {
      case PopupMenuPosition.over:
        offset = Offset.zero;
      case PopupMenuPosition.under:
        offset = Offset(0.0, button.size.height);
    }
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero) + offset,
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final item = await showMenu(
      context: context,
      position: position,
      initialValue: current,
      items: items.map((e) {
        return PopupMenuItem(
          value: e,
          child: Text(contentBuilder(e)),
        );
      }).toList(),
    );
    if (!context.mounted) return;
    if (item != null) {
      onTap(item);
    }
  }
}
