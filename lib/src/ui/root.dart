import 'package:dreambook/src/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/shared/code_routes.dart';
import 'widgets/about_button.dart';
import 'widgets/github_button.dart';
import 'widgets/theme_mode_button.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: CustomScrollView(
            slivers: [
              const SliverAppBar.large(
                title: Text('Dreambook'),
                actions: [
                  GithubButton(),
                  AboutButton(),
                  ThemeModeButton(),
                ],
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
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    onPressed: () {
                      PaintingRoute().go(context);
                    },
                    icon: const Icon(Icons.format_paint),
                    label: const Text('Painting'),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
