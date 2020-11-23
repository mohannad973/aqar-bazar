import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/screens/Auth/login.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:aqar_bazar/screens/Auth/signup.dart';

import 'new_home.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _navigateTo(context, page()) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, color: Colors.blue);
    const bodyStyleWhiteBackground =
        TextStyle(fontSize: 18, color: Colors.black54);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color(0xff015CA8),
      imagePadding: EdgeInsets.zero,
    );
    const pageDecorationWhiteBackground = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.w600, color: Colors.black87),
      bodyTextStyle: bodyStyleWhiteBackground,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title:  Applocalizations.of(context).translate("welcome to aqar"),
          body: Applocalizations.of(context).translate("welcome disc"),
          image: _buildImage('logo'),
          decoration: pageDecorationWhiteBackground,
        ),
        PageViewModel(
          title: Applocalizations.of(context).translate("own your dream house"),
          body: Applocalizations.of(context).translate("own your dream house disc"),
          image: _buildImage('house'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: Applocalizations.of(context).translate("you will find what you need"),
          body: Applocalizations.of(context).translate("you will find what you need disc"),
          image: _buildImage('realestate4'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: Applocalizations.of(context).translate("you will find what you need"),
          body: Applocalizations.of(context).translate("you will find what you need disc2"),
          image: _buildImage('realestate3'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: Applocalizations.of(context).translate("signin title"),
          body: Applocalizations.of(context).translate("signin disc"),
          image: _buildImage('hotel'),
          footer: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => LogIn()),
                  );
                },
                child:  Text(
                  Applocalizations.of(context).translate("signInBtn"),
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SignUp()),
                  );
                },
                child:  Text(
                  Applocalizations.of(context).translate("signUpBtn"),
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xff015CA8),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 0.5),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ],
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => NewHome()),
        );
      },
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip:  Text(
        Applocalizations.of(context).translate("skip"),
        style: TextStyle(
            color: Colors.white,
            fontSize: 17.0,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text('',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text("This is the screen after Introduction")),
    );
  }
}
