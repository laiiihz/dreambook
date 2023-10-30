import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @apiReference.
  ///
  /// In en, this message translates to:
  /// **'API Reference'**
  String get apiReference;

  /// No description provided for @appBar.
  ///
  /// In en, this message translates to:
  /// **'App Bar'**
  String get appBar;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Dreambook'**
  String get appName;

  /// No description provided for @badge.
  ///
  /// In en, this message translates to:
  /// **'Badge'**
  String get badge;

  /// No description provided for @bottomAppBar.
  ///
  /// In en, this message translates to:
  /// **'Bottom App Bar'**
  String get bottomAppBar;

  /// No description provided for @bottomSheet.
  ///
  /// In en, this message translates to:
  /// **'Bottom Sheet'**
  String get bottomSheet;

  /// No description provided for @button.
  ///
  /// In en, this message translates to:
  /// **'Button'**
  String get button;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @checkBox.
  ///
  /// In en, this message translates to:
  /// **'Check Box'**
  String get checkBox;

  /// No description provided for @chip.
  ///
  /// In en, this message translates to:
  /// **'Chip'**
  String get chip;

  /// No description provided for @container.
  ///
  /// In en, this message translates to:
  /// **'Container'**
  String get container;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @datePicker.
  ///
  /// In en, this message translates to:
  /// **'Date Picker'**
  String get datePicker;

  /// No description provided for @dialog.
  ///
  /// In en, this message translates to:
  /// **'Dialog'**
  String get dialog;

  /// No description provided for @divider.
  ///
  /// In en, this message translates to:
  /// **'Divider'**
  String get divider;

  /// No description provided for @drawer.
  ///
  /// In en, this message translates to:
  /// **'Drawer'**
  String get drawer;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @fab.
  ///
  /// In en, this message translates to:
  /// **'Floating Action Button'**
  String get fab;

  /// No description provided for @goGithub.
  ///
  /// In en, this message translates to:
  /// **'Go to Github'**
  String get goGithub;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @listTile.
  ///
  /// In en, this message translates to:
  /// **'List Tile'**
  String get listTile;

  /// No description provided for @navigationBar.
  ///
  /// In en, this message translates to:
  /// **'Navigation Bar'**
  String get navigationBar;

  /// No description provided for @navigationRail.
  ///
  /// In en, this message translates to:
  /// **'Navigation Rail'**
  String get navigationRail;

  /// No description provided for @popupMenuButton.
  ///
  /// In en, this message translates to:
  /// **'Popup Menu Button'**
  String get popupMenuButton;

  /// No description provided for @progressIndicator.
  ///
  /// In en, this message translates to:
  /// **'Progress Indicator'**
  String get progressIndicator;

  /// No description provided for @radio.
  ///
  /// In en, this message translates to:
  /// **'Radio'**
  String get radio;

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show All'**
  String get showAll;

  /// No description provided for @slider.
  ///
  /// In en, this message translates to:
  /// **'Slider'**
  String get slider;

  /// No description provided for @snackBar.
  ///
  /// In en, this message translates to:
  /// **'Snack Bar'**
  String get snackBar;

  /// No description provided for @switchItem.
  ///
  /// In en, this message translates to:
  /// **'Switch'**
  String get switchItem;

  /// No description provided for @tabBar.
  ///
  /// In en, this message translates to:
  /// **'Tab Bar'**
  String get tabBar;

  /// No description provided for @theType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get theType;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
