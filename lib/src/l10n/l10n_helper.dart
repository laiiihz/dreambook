import 'package:dreambook/src/utils/kv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'l10n_helper.g.dart';

extension L10nHelperExt on BuildContext {
  /// app localization
  AppLocalizations get tr => AppLocalizations.of(this)!;

  /// material localization
  MaterialLocalizations get mtr => MaterialLocalizations.of(this);

  /// about
  String get aboutLabel => mtr.aboutListTileTitle(tr.appName);

  String get alertDialog => tr.alertWith(tr.dialog);
}

@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  @override
  Locale? build() => KV.locale;

  void change(Locale? locale) {
    KV.locale = locale;
    state = locale;
  }
}

@Riverpod(keepAlive: true)
class ApiBaseUrl extends _$ApiBaseUrl {
  @override
  (String, String) build() => KV.apiBase;

  void change(String name) async {
    state = await KV.setApiBase(name);
  }
}

extension LocaleExt on Locale? {
  String name(BuildContext context) {
    return switch (this) {
      null => context.tr.followSystem,
      const Locale('en') => 'English',
      const Locale('zh') => '简体中文',
      _ => throw UnimplementedError(),
    };
  }
}
