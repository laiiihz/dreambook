import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/routes/routes.dart';
import 'package:dreambook/src/ui/widgets/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/shared/code_routes.dart';
import 'widgets/about_button.dart';
import 'widgets/adaptive_scaffold.dart';
import 'widgets/github_button.dart';
import 'widgets/settings_button.dart';
import 'widgets/theme_mode_button.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(context.tr.appName),
            actions: const [
              GithubButton(),
              AboutButton(),
              ThemeModeButton(),
              SettingsButton(),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid.extent(
              maxCrossAxisExtent: 280,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 5,
              children: [
                TypeButton(
                  title: context.tr.materialWidgets,
                  icon: const Material(
                    shape: StarBorder(
                      points: 8,
                      innerRadiusRatio: 0.8,
                      pointRounding: 0.2,
                      valleyRounding: 0.2,
                    ),
                    child: SizedBox.square(dimension: 16),
                  ),
                  onTap: () => MaterialRoute().go(context),
                ),
                TypeButton(
                  onTap: () => CupertinoRoute().go(context),
                  title: context.tr.cupertinoWidgets,
                  icon: const Icon(CupertinoIcons.square_stack_3d_up_fill),
                ),
                TypeButton(
                  onTap: () => PaintingRoute().go(context),
                  icon: const Icon(Icons.format_paint),
                  title: context.tr.paintingEffects,
                ),
                TypeButton(
                  onTap: () => BasicRoute().go(context),
                  icon: const Icon(Icons.widgets),
                  title: context.tr.basics,
                ),
                TypeButton(
                  onTap: () => ScrollingRoute().go(context),
                  icon: const Icon(Icons.list),
                  title: context.tr.scrolling,
                ),
                TypeButton(
                  onTap: () => LayoutRoute().go(context),
                  icon: const Icon(Icons.layers_outlined),
                  title: context.tr.layout,
                ),
                TypeButton(
                  onTap: () => TextRoute().go(context),
                  icon: const Icon(Icons.text_fields_rounded),
                  title: context.tr.text,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}

class TypeButton extends StatelessWidget {
  const TypeButton({
    super.key,
    required this.title,
    this.icon,
    required this.onTap,
  });

  final String title;
  final Widget? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style = FilledButton.styleFrom(
      minimumSize: const Size.fromHeight(56),
    );
    return icon == null
        ? FilledButton(style: style, onPressed: onTap, child: Text(title))
        : FilledButton.icon(
            style: style,
            onPressed: onTap,
            icon: icon!,
            label: Text(title),
          );
  }
}
