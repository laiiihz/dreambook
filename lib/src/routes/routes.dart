import 'package:dreambook/src/ui/pages/cupertino/cupertino_page_view.dart';
import 'package:dreambook/src/ui/pages/material/material_page_view.dart';
import 'package:dreambook/src/ui/root.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRoutes(AppRoutesRef ref) {
  return GoRouter(routes: $appRoutes);
}

@TypedGoRoute<RootRoute>(
  path: '/',
  routes: [
    TypedGoRoute<MaterialRoute>(path: 'material', name: 'material'),
    TypedGoRoute<CupertinoRoute>(path: 'cupertino', name: 'cupertino'),
  ],
)
class RootRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RootPage();
  }
}
