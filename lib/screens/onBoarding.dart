import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:skyva/screens/homeScreen.dart';

const bool kIsWeb = identical(0, 0.0);

class OnBoardingPage extends StatefulWidget {
  static const String id = 'OnBoardingPage';
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushReplacementNamed(context, HomeScreen.id);
  }

  Widget _buildFullscrenImage() {
    return Image.asset(
      'assets/images/background.JPG',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, color: Colors.black54);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          color: Colors.black54, fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
//      globalHeader: Align(
//        alignment: Alignment.topRight,
//        child: SafeArea(
//          child: Padding(
//            padding: const EdgeInsets.only(top: 16, right: 16),
//            child: _buildImage('tideyIc.png', 100),
//          ),
//        ),
//      ),
//      globalFooter: Container(
//        color: Colors.blueAccent,
//        width: double.infinity,
//        height: 60,
//        child: ElevatedButton(
//          child: const Text(
//            'Welcome to Tidey!',
//            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//          ),
//          onPressed: () => _onIntroEnd(context),
//        ),
//      ),
      pages: [
        PageViewModel(
          title: "Intro Screen1",
          body: "A little bit about my App.",
          image: _buildImage('OnBoard.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Intro Screen 2",
          body: "A little more about my App",
          image: _buildImage('OnBoard.png'),
          decoration: pageDecoration,
          footer: ElevatedButton(
            onPressed: () {
              // On button presed
            },
            child: const Text("More Information"),
          ),
        ),

        PageViewModel(
          title: "Intro Screen3",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Creating a more complicated "),
              Icon(Icons.edit),
              Text(" Intro Message"),
            ],
          ),
          //    body: "A little more more about my app",
          image: _buildImage('OnBoard.png'),
          decoration: pageDecoration,
        ),
//
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      color: Colors.white,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeColor: Color(0xFFFFD344),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
