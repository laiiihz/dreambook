import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../shared/shared_code_view.dart';
import 'widgets/widgets.dart';

class PaintingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PaintingPageView();
  }
}

class PaintingPageView extends StatelessWidget {
  const PaintingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painting Widgets'),
      ),
      body: SharedCodeView(paintingCodeItems),
    );
  }
}
