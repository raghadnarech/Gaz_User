import 'package:flutter/material.dart';
import 'package:gas_app/Controller/ServicesProvider.dart';
import 'package:gas_app/l10n/l10n.dart';

class LanguageProvider with ChangeNotifier {
  Locale? _locale;

  Future<void> getlocale() async {
    String localeCode = await ServicesProvider.getlocale();
    _locale = Locale(localeCode);
    notifyListeners();
  }

  Locale get locale => _locale ?? Locale('ar');

  void setlocale(Locale locale) async {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
    ServicesProvider.setlocale(locale.languageCode);
  }

  void clearLoacle() {
    _locale = null;
    notifyListeners();
  }
}
