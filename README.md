## Why fluent_i18n?

There are times that you want to access localization text without context,
For example, in a model class. 

This package use singleton to load Fluent Translation List (FTL) files. Localized strings can be accessed without the present of context (of course, it can also be accessed via context as well),  it also provides more convenient approach of writing less code and still localizing all the segments of the app.

## Getting Started

### 🔩 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  fluent_i18n: <last_version>
```

Create folder and add translation files like this

```
assets
└── i18n
    ├── {languageCode}.ftl                  //only language code
    └── {languageCode}_countryCode}.ftl     //or full locale code
```

Example:

```
assets
└── i18n
    ├── en.ftl
    └── en_US.ftl
```

Declare your assets localization directory in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/i18n/
```

### ⚠️ Note on **iOS**

For translation to work on **iOS** you need to add supported locales to 
`ios/Runner/Info.plist` as described [here](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#specifying-supportedlocales).

Example:

```xml
<key>CFBundleLocalizations</key>
<array>
	<string>en</string>
	<string>ja</string>
</array>
```

### ⚙️ Configuration app

Add EasyLocalization widget like in example

```dart
import 'package:fluent_i18n/fluent_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const List<Locale> SUPPORTED_LOCALES = [
	const Locale('ja'),
	const Locale('en'),	
];

Locale locale = SUPPORTED_LOCALES.first;

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			theme: ThemeData(
				primarySwatch: Colors.blue,
				visualDensity: VisualDensity.adaptivePlatformDensity,
			),
			home: MyHomePage(),
			locale:  locale,
			localizationsDelegates: [
				GlobalMaterialLocalizations.delegate,
				GlobalWidgetsLocalizations.delegate,
				FluentLocalizationsDelegate(SUPPORTED_LOCALES),
			],
			supportedLocales: SUPPORTED_LOCALES,
		);
	}
}
```

[**Full example**](https://github.com/ryanhz/fluent_i18n/blob/master/example/lib/main.dart)

## Usage

### 🔥 Change locale `setLocale()`

You can change the locale by calling
```dart
await FluentLocalizations.setLocale(locale);
```
This will change the current locale and load the corresponding ftl file.

Alternatively, you can call (this is what setLocale() does):
```dart
await FluentLocalizations.ofLocale(locale).load();
```

### 🔥 Translate `getMessage()`

Main function for translate your language keys

```dart
final i18n = FluentLocalizations.current();
Text(i18n.getMessage('home-title')) 
```

Or if you maintain the locale yourself, you can use
```dart
final i18n = FluentLocalizations.ofLocale(currentLocale);
...
// Load somewhere
await i18n.load();
...
Text(i18n.getMessage('home-title')) 
```
ℹ️ No breaking changes, you can use old the static method `FluentLocalizations.of(context)`
