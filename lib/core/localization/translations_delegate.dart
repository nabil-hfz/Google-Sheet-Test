 import 'package:flutter/material.dart';
import 'package:google_sheet_test/core/utils/appConfig.dart';

import 'translations.dart';

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      appConfig.supportedLocales.contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => false;
}
