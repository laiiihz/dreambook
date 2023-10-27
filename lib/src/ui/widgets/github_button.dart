import 'package:dreambook/src/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubButton extends ConsumerWidget {
  const GithubButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        launchUrl(Uri(
          scheme: 'https',
          host: 'github.com',
          path: '/laiiihz/dreambook',
        ));
      },
      icon: Image.asset(
        ref.watch(themeModeImageProvider),
        width: 24,
      ),
    );
  }
}
