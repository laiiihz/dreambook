import 'package:dreambook/src/ui/pages/material/widgets.dart';
import 'package:dreambook/src/ui/pages/painting/widgets.dart';
import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/material.dart' hide MaterialPage;
import 'package:go_router/go_router.dart';

class MaterialRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NamedCodeScaffold(
        title: 'Material Widgets', items: materialCodeItems);
  }
}

class CupertinoRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NamedCodeScaffold(title: 'Cupertino', items: []);
  }
}

class PaintingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NamedCodeScaffold(
        title: 'Painting Widgets', items: paintingCodeItems);
  }
}