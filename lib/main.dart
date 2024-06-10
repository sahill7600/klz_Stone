import 'dart:async';
import 'package:KLZStone/pages/Nav/NavToNewPageBottomNav.dart';
import 'package:KLZStone/pages/introduction_screen.dart';
import 'package:KLZStone/utils/PreferenceManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(color: Colors.white)),
    home:
    SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  static String tag = 'splashScreen';

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), checkFirstSeen);
  }

  Future checkFirstSeen() async {
    if (await PreferenceManager().getPref("isLogin") != "1") {
      PreferenceManager().setPref("isLogin", "0");
      PreferenceManager().setPref("usertype", "0");
    }

    String isLoginString = await PreferenceManager().getPref("isLogin");

    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (context) => OnBoardingPage()

    ));

    /*if (isLogin == "1") {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new HomePage()));
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginFirstPage()));
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image(image: AssetImage('assets/logo.jpeg')),
                    SizedBox(height: 80),
                    SizedBox(
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                      height: 30.0,
                      width: 30.0,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
