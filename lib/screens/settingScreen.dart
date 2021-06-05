import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyva/components/tileWidgets.dart';
import 'package:skyva/globalsAndConstants.dart';
import 'package:skyva/screens/helpScreen.dart';
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  static const String id = 'settingScreen';
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SharedPreferences prefs;
  bool _userSetting1 = userSettings.userSetting1.value;
  @override
  void initState() {
    openPerfs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Setting'),
        centerTitle: true,
        //  backgroundColor: kAppBarColor,
      ),
      body:
//      Column  (
//        children: [
          SwipeGestureRecognizer(
        onSwipeLeft: () {
          Navigator.of(context).pop();
        },
        child: Container(
          constraints: BoxConstraints.expand(),
          child: ListView(
            children: [
              Column(
                children: [
                  Divider(
                    height: 10,
                    thickness: 5,
                  ),
                  MenuListTileWithSwitch(
                      title: (userSettings.userSetting1.value)
                          ? "Example User Setting (Enabled)"
                          : "Example User Setting (Disabled)",
                      value: userSettings.userSetting1.value,
                      icon: Icons.settings,
                      onTap: () {
                        setState(() {
                          userSettings.userSetting1.value =
                              !userSettings.userSetting1.value;
                          _userSetting1 = userSettings.userSetting1.value;

                          prefs.setBool(userSettings.userSetting1.key,
                              userSettings.userSetting1.value);
                        });
                      }),
                  Divider(
                    thickness: 5,
                  ),
                  MenuListTile(
                    title: "Tell a friend about " + appName,
                    icon: Icons.share,
                    onTap: () => {
                      if (userDevice.isIOS)
                        {
                          Share.share('Download our cool new App' + appName,
                              subject: 'Check Out ' +
                                  appName +
                                  '\n  ' +
                                  appleStoreURL)
                        }
                      else
                        {
                          Share.share('Download our cool new App' + appName,
                              subject: 'Check Out ' +
                                  appName +
                                  '\n  ' +
                                  androidStoreURL)
                        }
                    },
                  ),
                  Divider(
                    height: 10,
                    thickness: 5,
                  ),

                  //
                  MenuListTile(
                      title: "Rate Us",
                      icon: Icons.star,
                      onTap: () => {
                            OpenAppstore.launch(
                                androidAppId: androidAppId, iOSAppId: iOSAppId)
                          }),
                  Divider(
                    height: 10,
                    thickness: 5,
                  ),
                  MenuListTile(
                      title: "Contact Us",
                      icon: Icons.email,
                      onTap: () => {sendemail()}),
                  Divider(
                    height: 10,
                    thickness: 5,
                  ),
                  MenuListTile(
                    title: "About",
                    icon: Icons.info_outline_rounded,
                    onTap: () => {
                      showAlert(
                          context,
                          appName,
                          "Version " +
                              packageInfo.version +
                              " Build " +
                              packageInfo.buildNumber +
                              "\n\nDeveloped by " +
                              companyName +
                              "\n")
                    },
                  ),
                  Divider(
                    height: 10,
                    thickness: 5,
                  ),
                  MenuListTile(
                    title: "Help",
                    icon: Icons.help,
                    onTap: () => {Navigator.pushNamed(context, HelpScreen.id)},
                  ),
                  Divider(
                    height: 10,
                    thickness: 5,
                  ),
                  ListTile(
                    title: Text(
                      "Version",
                    ),
                    trailing: Text(
                      packageInfo.version + "(" + packageInfo.buildNumber + ")",
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openPerfs() async {
    prefs = await SharedPreferences.getInstance();
  }

  sendemail() async {
    final Uri _emailLaunchUri =
        Uri(scheme: 'mailto', path: supportEmail, queryParameters: {
      'subject': 'Hi from your number 1 fan!',
      'body': '\n\n\n' +
          appName +
          packageInfo.version +
          "(" +
          packageInfo.buildNumber +
          ")" +
          userDevice.osVersion +
          '\n' +
          userDevice.manufacturer +
          '\n' +
          userDevice.model +
          '\n'
    });
    print("Read to Send \n" + _emailLaunchUri.toString());
//    const url =
////        'mailto:support@amberjacklabs.com?subject=Hi from Tideys 1 Fan&body=Hello';
//        'mailto:support@amberjacklabs.com';
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }
}
