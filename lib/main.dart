import 'package:flutter/material.dart';
import '../home.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/constants.dart';
import 'Widget/login_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:localization/localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await EasyLocalization.ensureInitialized();

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

bool displayAds = false;
bool isLoginn = false;
String language = 'cn';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];

    return FutureBuilder<dynamic>(
        future: _getLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.hasData == null) {
            return ScreenUtilInit(
              designSize: const Size(1080, 1920),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'First Method',
                builder: EasyLoading.init(),
                // You can use the library anywhere in the app even in theme
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  textTheme:
                      Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
                ),
                home: isLoginn ? home() : LoginPage(),
              ),
              child: LoginPage(),
            );
          }
          return EasyLocalization(
            path: 'lib/i18n',
            supportedLocales: [
              Locale('en', ''),
              Locale('bm', ''),
              Locale('cn', ''),
            ],
            fallbackLocale: Locale('en', ''),
            child: ScreenUtilInit(
              designSize: const Size(1080, 1920),
              // designSize: const Size(360, 480),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) => MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                builder: EasyLoading.init(),
                // localizationsDelegates: [
                //   GlobalMaterialLocalizations.delegate,
                //   GlobalWidgetsLocalizations.delegate,
                //   GlobalCupertinoLocalizations.delegate,
                //   LocalJsonLocalization.delegate,
                // ],

                // localeResolutionCallback: (locale, supportedLocales) {
                //   // if (supportedLocales.contains(locale)) {
                //   //   return locale;
                //   // }

                //   // define pt_BR as default when de language code is 'pt'
                //   if (language == 'en') {
                //     return Locale('en', '');
                //   } else if (language == 'bm') {
                //     return Locale('bm', '');
                //   } else if (language == 'cn') {
                //     return Locale('cn', '');
                //   }

                //   // default language
                //   // return Locale('en', 'US');
                // },
                debugShowCheckedModeBanner: false,
                title: 'First Method',
                // You can use the library anywhere in the app even in theme
                theme:
                    // Theme.of(context).copyWith(
                    //   colorScheme: Theme.of(context).colorScheme.copyWith(
                    //         primary: Constants.COLORS_PRIMARY_COLOR,
                    //       ),
                    //   textTheme:
                    //       Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
                    // ),
                    ThemeData(
                  primarySwatch: Colors.blue,
                  textTheme:
                      Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
                ),
                home: isLoginn ? home() : LoginPage(),
              ),
            ),
          );
        });
  }

  Future _getLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;
    String lastLanguage = prefs.getString(Constants.PREF_LANGUAGE) ?? 'en';
    isLoginn = isLogin;
    language = lastLanguage;
    prefs.setBool(Constants.PREF_DISPLAY_ADS, displayAds);
    FlutterNativeSplash.remove();
  }
}
