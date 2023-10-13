import 'package:dreambook/src/routes/routes.dart';
import 'package:dreambook/src/ui/pages/cupertino/cupertino_page_view.dart';
import 'package:dreambook/src/ui/pages/material/material_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Dreambook'),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.list(children: [
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                onPressed: () {
                  MaterialRoute().go(context);
                },
                icon: const Material(
                  shape: StarBorder(
                    points: 8,
                    innerRadiusRatio: 0.8,
                    pointRounding: 0.2,
                    valleyRounding: 0.2,
                  ),
                  child: SizedBox.square(dimension: 16),
                ),
                label: const Text('Material Widgets'),
              ),
              const SizedBox(height: 16),
              CupertinoButton.filled(
                onPressed: () {
                  CupertinoRoute().go(context);
                },
                child: const Text('Cupertino'),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
