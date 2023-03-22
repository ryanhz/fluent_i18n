import 'package:fluent_i18n/fluent_i18n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Strings {
  static String get appTitle => translate("app-title");
  static String get homeTitle => translate("home-title");
  static String pushedButtonThisManyTimes(int counter) => translate(
      'you-have-pushed-the-button-this-many-times', {'counter': counter});
  static String get increment => translate("increment");

  static String translate(String key, [Map<String, dynamic> args = const {}]) {
    String translated =
        FluentLocalizations.current()?.getMessage(key, args) ?? '!$key!';
    return translated;
  }

  static Future<bool> applyLocale(Locale locale) async {
    final i18n = FluentLocalizations.current();
    if (locale != i18n?.locale) {
      await FluentLocalizations.setLocale(locale);
      Intl.defaultLocale = locale.toString();
      return true;
    }
    return false;
  }
}
