import 'package:dreambook/src/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension L10nHelperExt on BuildContext {
  /// app localization
  AppLocalizations get tr => AppLocalizations.of(this)!;

  /// material localization
  MaterialLocalizations get mtr => MaterialLocalizations.of(this);

  /// about
  String get aboutLabel => mtr.aboutListTileTitle(tr.appName);

  String get alertDialog => tr.alertWith(tr.dialog);
}
