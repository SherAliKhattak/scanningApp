import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:scanningapp/providers/theme_provider.dart';
import 'package:scanningapp/dependencies/init.dart';
import 'package:scanningapp/language_Constants/language_constants.dart';
import 'package:scanningapp/onboarding_screen_pageview.dart';
import 'package:scanningapp/services/local_db.dart';
import 'package:scanningapp/themes.dart';
import 'screens/onboarding_screens/upload_on_cloud_screen.dart';
import 'screens/onboarding_screens/print_your_doc_screen.dart';
import 'screens/main_screens/home_screen.dart';
import 'screens/main_screens/settings_screen.dart';
import 'screens/main_screens/convert_to_pdf_screen/covert_to_pdf_screen.dart';
import 'screens/main_screens/favourites.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    PreferencesServices().getDarkmode();
    PreferencesServices().getFavoritesList();

    getLocale().then((locale) => setLocale(locale));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, snapshot) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return GetMaterialApp(
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            debugShowCheckedModeBanner: false,
            // theme: MyThemes.lightTheme,
            // darkTheme: MyThemes.darkTheme,
            routes: {
              UploadOnCloudScreen.id: (context) => const UploadOnCloudScreen(),
              PrintYourDocScreen.id: (context) => const PrintYourDocScreen(),
              HomeScreen.id: (context) => const HomeScreen(),
              SettingsScreen.id: (context) => const SettingsScreen(),
              ConvertToPdf.id: (context) => const ConvertToPdf(
                  // files: [],
                  ),
              FavouritesScreen.id: (context) => const FavouritesScreen(),
            },
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: _locale,
            home: const OnBoardingScreen(),
            initialBinding: HomeBinding(),
          );
        });
  }
}
