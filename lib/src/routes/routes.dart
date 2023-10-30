import 'package:dreambook/src/ui/pages/shared/code_routes.dart';
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
    TypedGoRoute<PaintingRoute>(path: 'painting', name: 'painting'),
    TypedGoRoute<BasicRoute>(path: 'basic', name: 'basic'),
  ],
)
class RootRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RootPage();
  }
}
