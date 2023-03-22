import 'package:fluent/fluent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class FluentLocalizations {
  Locale locale;
  FluentBundle bundle;

  String? getMessage(String key, [Map<String, dynamic> args = const {}]) {
    List<Error> errors = [];
    final translated = bundle.format(key, args: args, errors: errors);
    if (errors.length > 0) {
      print("[ERROR] $errors");
    }
    return translated;
  }

  Future<FluentLocalizations> load() async {
    final path = 'assets/i18n/$locale.ftl';
    final source = await rootBundle.loadString(path);
    this.addMessages(source);
    return this;
  }

  void addMessages(String source) {
    bundle.addMessages(source);
  }

  factory FluentLocalizations.ofLocale(Locale locale) {
    var i18n = languages[locale] ?? FluentLocalizations._internal(locale);
    languages[locale] = i18n;
    currentLocale = locale;
    return i18n;
  }

  FluentLocalizations._internal(this.locale)
      : bundle = FluentBundle(locale.toString());

  static final Map<Locale, FluentLocalizations> languages = {};

  static Future<void> setLocale(Locale locale) {
    return FluentLocalizations.ofLocale(locale).load();
  }

  static FluentLocalizations? current() {
    if (currentLocale == null) {
      return null;
    }
    return FluentLocalizations.ofLocale(currentLocale!);
  }

  static Locale? currentLocale;

  /// helper for getting [FluentLocalizations] object
  static FluentLocalizations? of(BuildContext context) =>
      Localizations.of<FluentLocalizations>(context, FluentLocalizations);
}

class FluentLocalizationsDelegate
    extends LocalizationsDelegate<FluentLocalizations> {
  final List<Locale> supportLocales;
  const FluentLocalizationsDelegate(this.supportLocales);

  @override
  bool isSupported(Locale locale) {
    return supportLocales
        .map((locale) => locale.languageCode)
        .contains(locale.languageCode);
  }

  @override
  Future<FluentLocalizations> load(Locale locale) async {
    return FluentLocalizations.ofLocale(locale).load();
  }

  @override
  bool shouldReload(LocalizationsDelegate<FluentLocalizations> old) {
    return false;
  }
}
