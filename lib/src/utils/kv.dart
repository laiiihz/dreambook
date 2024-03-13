import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KV {
  static late SharedPreferences _instance;
  static Future ensureInitialized() async {
    _instance = await SharedPreferences.getInstance();
  }

  static bool get darkMode => _instance.getBool('darkMode') ?? false;

  static set darkMode(bool state) => _instance.setBool('darkMode', state);

  static bool get showAllCode => _instance.getBool('showAllCode') ?? false;
  static set showAllCode(bool state) => _instance.setBool('showAllCode', state);

  static Locale? get locale {
    final lang = _instance.getString('locale_lang');
    final country = _instance.getString('locale_country');
    if (lang == null) return null;
    return Locale(lang, country);
  }

  static set locale(Locale? state) {
    if (state == null) {
      _instance.remove('locale_lang');
      _instance.remove('locale_country');
      return;
    }
    _instance.setString('locale_lang', state.languageCode);
    if (state.countryCode != null) {
      _instance.setString('locale_country', state.countryCode!);
    }
  }

  static (String, String) get apiBase {
    String key = _instance.getString('apiBase') ?? 'Origin';
    if (!apiBaseMap.containsKey(key)) {
      key = 'Origin';
    }
    return (key, apiBaseMap[key]!);
  }

  static setApiBase(String name) async {
    await _instance.setString('apiBase', name);
    return KV.apiBase;
  }
}

const apiBaseMap = {
  'Origin': 'api.flutter.dev',
  'China': 'api.flutter-io.cn',
};
