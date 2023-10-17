import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/screens/splash_screen.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/AppLocalizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  print("base_url: ${GlobalConfiguration().getString('base_url')}");
  SharedPreferences.getInstance().then((prefs) async {
    String local ;
    if (prefs.getString('local') != null) {
      local = prefs.getString('local');
    }
    await runApp(MultiProvider(providers: [
      ChangeNotifierProvider<Provider_control>(
        create: (_) => Provider_control(local),
      ),
      ChangeNotifierProvider<Provider_Data>(
        create: (_) => Provider_Data(),
      ),
    ], child: Phoenix(child: MyApp())));
  });
}

class MyApp extends StatefulWidget {
  static void setlocal(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setlocal(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setlocal(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
  //  getIntial();
    _locale=Provider.of<Provider_control>(context, listen: false).local==null?null: Locale(Provider.of<Provider_control>(context, listen: false).local, "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      localeResolutionCallback: (devicelocale, supportedLocales) {
        WidgetsBinding.instance.addPostFrameCallback((_){
          themeColor.setLocal(devicelocale.languageCode);
        });
        for (var locale in supportedLocales) {
          if (locale.languageCode == devicelocale.languageCode ) {

            //return Locale(devicelocale.languageCode,'');
            return Locale("ar", "");
          }
        }
        return supportedLocales.first;
      },
      supportedLocales: [
        Locale("ar", ""),
      ],
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
        primaryColor:  Color(0xff424242),
        appBarTheme: AppBarTheme(color: Color(0xff424242),iconTheme: IconThemeData(color: Colors.white)),
        fontFamily: 'Cairo',
        textTheme: TextTheme(
          caption: TextStyle(
              height: 1.5
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: themeColor.getColor(),
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: SplashScreen(),
    );
  }

}
