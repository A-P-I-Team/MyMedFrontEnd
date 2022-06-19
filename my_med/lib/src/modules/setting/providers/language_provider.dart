import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:provider/provider.dart';

enum Language { persian, english }

class LanguageProvider extends ChangeNotifier {
  final BuildContext context;
  Locale? _language;

  LanguageProvider(this.context) {
    if (context.owner == null) return;
    _language = context.read<LocalizationProvider>().locale;
  }

  Locale? get language => _language;

  void changeLanguage(Locale? language) {
    _language = language;
    if (context.owner == null) return;
    context.read<LocalizationProvider>().setLocale(_language);
    notifyListeners();
  }

  void popScreen() {
    context.router.pop();
  }
}
