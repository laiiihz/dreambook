import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/pages/basic/widgets.dart';
import 'package:dreambook/src/ui/pages/cupertino/widgets.dart';
import 'package:dreambook/src/ui/pages/layout/widgets.dart';
import 'package:dreambook/src/ui/pages/material/widgets.dart';
import 'package:dreambook/src/ui/pages/painting/widgets.dart';
import 'package:dreambook/src/ui/pages/scrolling/widgets.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:dreambook/src/ui/pages/text/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide MaterialPage;
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MaterialRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NamedCodeScaffold(
      title: 'Material Widgets',
      items: materialCodeItems,
      actions: [
        IconButton(
          tooltip: context.tr.materialDesign,
          onPressed: () {
            launchUrlString('https://m3.material.io/');
          },
          icon: const Icon(CupertinoIcons.book),
        ),
      ],
    );
  }
}

class CupertinoRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NamedCodeScaffold(
      title: 'Cupertino',
      items: cupertinoItems,
      actions: [
        IconButton(
          tooltip: context.tr.cupertinoGuide,
          onPressed: () {
            launchUrlString(
                'https://developer.apple.com/design/human-interface-guidelines/');
          },
          icon: const Icon(CupertinoIcons.book),
        ),
      ],
    );
  }
}

class PaintingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NamedCodeScaffold(
        title: 'Painting Widgets', items: paintingCodeItems);
  }
}

class BasicRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NamedCodeScaffold(title: 'Basic Widgets', items: basicCodeItems);
  }
}

class LayoutRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NamedCodeScaffold(title: 'Layout', items: layoutCodeItems);
  }
}

class ScrollingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NamedCodeScaffold(title: 'Scrolling', items: scrollingCodeItems);
  }
}

class TextRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NamedCodeScaffold(title: 'Text', items: textCodeItems);
  }
}
