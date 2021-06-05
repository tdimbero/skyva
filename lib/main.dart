import 'package:flutter/material.dart';
import 'package:skyva/globalsAndConstants.dart';
import 'package:skyva/screens/helpScreen.dart';
import 'package:skyva/screens/homeScreen.dart';
import 'package:skyva/screens/onBoarding.dart';
import 'package:skyva/screens/settingScreen.dart';
import 'package:skyva/screens/splashScreen.dart';

void main() async {
  // imageCache.clear();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // print("firebase initialized, ${DateTime.now()}");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App Template',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: kPrimaryColor,
          accentColor: Colors.greenAccent,
          appBarTheme: AppBarTheme(color: kAppBarColor),
          iconTheme: IconThemeData(color: kIconColor),
          //  fontFamily: 'Georgia',
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: kPrimaryColor,
          //  fontFamily: 'Georgia',
        ),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          HelpScreen.id: (context) => HelpScreen(),
          OnBoardingPage.id: (context) => OnBoardingPage(),
          SettingScreen.id: (context) => SettingScreen(),
        });
  }
}
