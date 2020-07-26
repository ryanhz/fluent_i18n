import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fluent_i18n/fluent_i18n.dart';

void main() {
  test('Singleton', () {
    final locale = Locale('en', 'NZ');
    final i18n1 = FluentLocalizations.ofLocale(locale);
    final i18n2 = FluentLocalizations.ofLocale(locale);
    expect(i18n1, i18n2);
  });
}
