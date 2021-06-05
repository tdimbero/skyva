import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

const appName = "Amberjack Template"; // replace with app name
const appleStoreURL = 'https://apps.apple.com/us/app/tidey-clock/id1566159762';
const androidStoreURL =
    'https://play.google.com/store/apps/details?id=com.amberjacklabs.tidey';
const iOSAppId = "15661597xx"; //replace with app store id
const androidAppId = "com.amberjacklabs.xxxx"; // replace with andriod package
const supportEmail = "support@amberjacklabs.com";
const prodServerURL = 'https://shoebox.veloxe.com/';
const localServerURL = 'http://192.168.1.250:5000/';
const serverURL = localServerURL;
const versionURL = 'https://tideyparams.amberjacklabs.com';
const apiURL = serverURL + 'api/';
const companyName = "Amberjack Labs";

const kAppBarColor = kPrimaryColor;
const kIconColor = kPrimaryColor;
const kTextAndIconColor = Color(0xFFFFFFFF);
const kPrimaryTextColor = Color(0xFF212121);
const kSecondaryTextColor = Color(0xFF757575);
const kPrimaryColor = Colors.teal;

const kIconSettingSize = 30.0;
const kTextSettingsStyle = 30.0;

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
  color: kPrimaryTextColor,
);

/*  Global Variables */
String gLatitude = "";
String gLongitude = "";
Dio dio;

PackageInfo packageInfo = PackageInfo();
UserSetting userSettings = UserSetting();
DeviceDetails userDevice = DeviceDetails();

class UserSetting {
  IntKey numUsages = IntKey(0, "numUsages");
  StringKey deviceID = StringKey(null, "deviceID");
  BoolKey userSetting1 = BoolKey(false, "userSetting1");
  BoolKey retiredRelease = BoolKey(false, "retiredRelease");
}

class BoolKey {
  bool value;
  String key;
  BoolKey(this.value, this.key);
}

class IntKey {
  int value;
  String key;
  IntKey(this.value, this.key);
}

class StringKey {
  String value;
  String key;
  StringKey(this.value, this.key);
}

class DeviceDetails {
  double screenWidth;
  double screenHeight;
  double blockSizeHorizontal;
  double blockSizeVertical;

  double safeBlockHorizontal;
  double safeBlockVertical;

  bool isPhone;
  bool isTablet;
  bool hasNotch;
  bool isAndroid;
  bool isIOS;
  String osVersion;
  String manufacturer;
  String model;
}
