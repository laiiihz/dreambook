import 'package:dreambook/src/l10n/l10n_helper.dart';
import 'package:dreambook/src/ui/widgets/adaptive_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ResourceLicenseButton extends StatelessWidget {
  const ResourceLicenseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        ResourceLicensePage.push(context);
      },
      child: Text(context.tr.resourceLicenses),
    );
  }
}

class ResourceLicensePage extends StatelessWidget {
  const ResourceLicensePage({super.key});

  static Future push(BuildContext context) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ResourceLicensePage()));

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(context.tr.resourceLicenses),
          ),
          SliverList.list(
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Ocean View During Daytime'),
                subtitle: const Text('Photo by Ian Schneider'),
                onTap: () {
                  launchUrlString(
                      'https://unsplash.com/photos/ocean-view-during-daytime-XJfHMPJ0e-g?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash');
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Blue Starry Night Sky'),
                subtitle: const Text('Photo by Mink Mingle'),
                onTap: () {
                  launchUrlString(
                      'https://unsplash.com/photos/blue-starry-night-sky-NORa8-4ohA0?utm_content=creditShareLink&utm_medium=referral&utm_source=unsplash');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
