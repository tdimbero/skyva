import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyva/globalsAndConstants.dart';
import 'package:skyva/screens/homeScreen.dart';
import 'package:skyva/screens/onBoarding.dart';
import 'package:skyva/services/deviceInfoService.dart';
import 'package:skyva/services/localStorage.dart';
import 'package:skyva/services/locationServices.dart';
import 'package:skyva/services/releaseStatusService.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splashScreen';
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initAll();
  }

  @override
  Widget build(BuildContext context) {
    getDeviceInfo(context);
    return Scaffold(
      body: Center(
        child: Text('Put Some Cool Splash Screen Here'),
      ),
    );
  }

  void initAll() async {
    const locationErrorSnackBar = SnackBar(
      //  backgroundColor: (Colors.blue),
      content: Text('Location Services disabled using default location, '),
      duration: const Duration(milliseconds: 3000),
    );
    if (dio == null) {
      BaseOptions options = new BaseOptions(
          baseUrl: "your base url",
          receiveDataWhenStatusError: true,
          connectTimeout: 30 * 1000, // 30 seconds
          receiveTimeout: 30 * 1000 // 30 seconds
          );

      dio = new Dio(options);
    }
    await getProfileData();
    packageInfo = await PackageInfo.fromPlatform();
    VersionService releaseInfo = VersionService();
    await releaseInfo.getReleaseData();
    print("Did I return");
    if (releaseInfo.needsUpdate) {
      print("Update Required");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userSettings.retiredRelease.value =
          readBoolFromLocal(prefs, userSettings.retiredRelease.key, true);
      await _updateRequiredAlert(context);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userSettings.retiredRelease.value =
          readBoolFromLocal(prefs, userSettings.retiredRelease.key, false);
      if (releaseInfo.updateAvailable) {
        print("Update Available");
        await _updateAvailableAlert(context);
      }
    }

    Location location = Location();
    if (await location.getCurrentLocation()) {
      print("returned from location");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(locationErrorSnackBar);
    }
    if (userSettings.numUsages.value < 2) {
      Navigator.pushReplacementNamed(context, OnBoardingPage.id);
    } else {
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    }
  }
}

Future<void> getProfileData() async {
  print("Getting profile Data");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userSettings.deviceID.value = await readDeviceIDFromLocal(prefs);
  userSettings.retiredRelease.value =
      readBoolFromLocal(prefs, userSettings.retiredRelease.key, false);
  userSettings.userSetting1.value =
      readBoolFromLocal(prefs, userSettings.userSetting1.key, false);
  userSettings.numUsages.value = updateNumberOfUsages(prefs);
}

Future _updateAvailableAlert(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text("Release Update Available"),
      content: Text("This is a new release of " +
          appName +
          " available, please update to take advantage of the latest and greatest features."),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();

            OpenAppstore.launch(androidAppId: androidAppId, iOSAppId: iOSAppId);
          },
          child: Text("Upgrade Now"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: Text("Later"),
        ),
      ],
    ),
  );
}

Future _updateRequiredAlert(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(appName + " " + packageInfo.version + " is Retired"),
      content: Text("Release " +
          packageInfo.version +
          " of " +
          appName +
          "  has served you well, but has been retired, please download the latest version to continue. Please make sure you are connected to the network the first time you open Tidey after the upgrade."),

//        ],
    ),
  );
}
