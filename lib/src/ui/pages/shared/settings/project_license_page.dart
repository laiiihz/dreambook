import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/widgets/adaptive_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ProjectLicenseRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProjectLicensePage();
  }
}

class ProjectLicensePage extends StatelessWidget {
  const ProjectLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(context.tr.projectLicense),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: FutureBuilder(
                  future: rootBundle.loadString('LICENSE'),
                  builder: (context, snapshot) {
                    return SelectableText(snapshot.data ?? '');
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
