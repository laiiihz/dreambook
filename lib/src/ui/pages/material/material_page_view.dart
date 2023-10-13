import 'package:dreambook/src/ui/pages/shared/shared_code_view.dart';
import 'package:flutter/material.dart' hide MaterialPage;
import 'package:go_router/go_router.dart';

import 'widgets/widgets.dart';

class MaterialRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MaterialPage();
  }
}

class MaterialPage extends StatelessWidget {
  const MaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Widgets'),
      ),
      body: SharedCodeView(materialCodeItems),
    );
  }
}
