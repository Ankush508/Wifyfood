import 'package:flutter/material.dart';
import 'package:wifyfood/Language/language_ar.dart';
import 'package:wifyfood/Language/language_bn.dart';
import 'package:wifyfood/Language/language_ml.dart';
import 'package:wifyfood/Language/language_ta.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/Language/language_en.dart';
import 'package:wifyfood/Language/language_hi.dart';
import 'package:wifyfood/Language/language_gu.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'gu', 'hi', 'bn', 'ar', 'ta', 'ml'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'hi':
        return LanguageHi();
      case 'gu':
        return LanguageGu();
      case 'bn':
        return LanguageBn();
      case 'ar':
        return LanguageAr();
      case 'ta':
        return LanguageTa();
      case 'ml':
        return LanguageMl();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
