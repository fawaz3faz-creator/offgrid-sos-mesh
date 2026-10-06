import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/localization/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/home_page.dart';

class OffGridSOSApp extends StatefulWidget {
  const OffGridSOSApp({super.key, required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  State<OffGridSOSApp> createState() => _OffGridSOSAppState();
}

class _OffGridSOSAppState extends State<OffGridSOSApp> {
  Locale _locale = const Locale('ar');

  @override
  void initState() {
    super.initState();
    final stored = widget.sharedPreferences.getString('app_locale');
    if (stored != null && stored.isNotEmpty) {
      _locale = Locale(stored);
    }
  }

  Future<void> _changeLocale(Locale locale) async {
    await widget.sharedPreferences.setString('app_locale', locale.languageCode);
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    final dir = _locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Directionality(
      textDirection: dir,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OffGrid SOS Mesh',
        locale: _locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: AppTheme.darkTheme,
        home: HomePage(
          locale: _locale,
          onLocaleChanged: _changeLocale,
          sharedPreferences: widget.sharedPreferences,
        ),
      ),
    );
  }
}
