import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CupertinoRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CupertinoPage();
  }
}

class CupertinoPage extends StatelessWidget {
  const CupertinoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cupertino'),
      ),
    );
  }
}
