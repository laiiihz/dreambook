// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $rootRoute,
    ];

RouteBase get $rootRoute => GoRouteData.$route(
      path: '/',
      factory: $RootRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'material',
          name: 'material',
          factory: $MaterialRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'cupertino',
          name: 'cupertino',
          factory: $CupertinoRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'painting',
          name: 'painting',
          factory: $PaintingRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'basic',
          name: 'basic',
          factory: $BasicRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'layout',
          name: 'layout',
          factory: $LayoutRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'scrolling',
          name: 'scrolling',
          factory: $ScrollingRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'text',
          name: 'text',
          factory: $TextRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'settings',
          name: 'settings',
          factory: $SettingsRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'LICENSE',
              name: 'license',
              factory: $ProjectLicenseRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $RootRouteExtension on RootRoute {
  static RootRoute _fromState(GoRouterState state) => RootRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MaterialRouteExtension on MaterialRoute {
  static MaterialRoute _fromState(GoRouterState state) => MaterialRoute();

  String get location => GoRouteData.$location(
        '/material',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CupertinoRouteExtension on CupertinoRoute {
  static CupertinoRoute _fromState(GoRouterState state) => CupertinoRoute();

  String get location => GoRouteData.$location(
        '/cupertino',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PaintingRouteExtension on PaintingRoute {
  static PaintingRoute _fromState(GoRouterState state) => PaintingRoute();

  String get location => GoRouteData.$location(
        '/painting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BasicRouteExtension on BasicRoute {
  static BasicRoute _fromState(GoRouterState state) => BasicRoute();

  String get location => GoRouteData.$location(
        '/basic',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LayoutRouteExtension on LayoutRoute {
  static LayoutRoute _fromState(GoRouterState state) => LayoutRoute();

  String get location => GoRouteData.$location(
        '/layout',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ScrollingRouteExtension on ScrollingRoute {
  static ScrollingRoute _fromState(GoRouterState state) => ScrollingRoute();

  String get location => GoRouteData.$location(
        '/scrolling',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TextRouteExtension on TextRoute {
  static TextRoute _fromState(GoRouterState state) => TextRoute();

  String get location => GoRouteData.$location(
        '/text',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => SettingsRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProjectLicenseRouteExtension on ProjectLicenseRoute {
  static ProjectLicenseRoute _fromState(GoRouterState state) =>
      ProjectLicenseRoute();

  String get location => GoRouteData.$location(
        '/settings/LICENSE',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appRoutesHash() => r'ec4be30f3de939606bb7d15eedeb84a2f00fa112';

/// See also [appRoutes].
@ProviderFor(appRoutes)
final appRoutesProvider = Provider<GoRouter>.internal(
  appRoutes,
  name: r'appRoutesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appRoutesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppRoutesRef = ProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
