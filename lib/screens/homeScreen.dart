import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skyva/globalsAndConstants.dart';
import 'package:skyva/screens/helpScreen.dart';
import 'package:skyva/screens/onBoarding.dart';
import 'package:skyva/screens/settingScreen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Welcome"),
        leading: IconButton(
          icon: Icon(Icons.help),
          onPressed: () => Navigator.pushNamed(context, HelpScreen.id),
        ),
        //   backgroundColor: kAppBarColor,
      ),
      body: Builder(builder: (BuildContext context) {
        return SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                // child: Image.asset('assets/images/banner.png'),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text('View Settings Screen'),
                leading: Icon(
                  Icons.settings,
                  color: kIconColor,
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(context, SettingScreen.id);
                },
              ),
              ListTile(
                title: Text('View Help Screen'),
                leading: Icon(
                  Icons.help,
                  color: kIconColor,
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(context, HelpScreen.id);
                },
              ),
              ListTile(
                title: Text('On Boarding Screens'),
                leading: Icon(
                  Icons.category,
                  color: kIconColor,
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(context, OnBoardingPage.id);
                },
              ),
              ListTile(
                title: Text('Edit my Profile'),
                leading: Icon(
                  Icons.person,
                  color: kIconColor,
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  //   Navigator.pushNamed(context, firstScreen.id);
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
