import 'package:KLZStone/pages/Nav/NavToNewPageBottomNav.dart';
import 'package:KLZStone/utils/PreferenceManager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Future checkFirstSeen() async {
    if (await PreferenceManager().getPref("isLogin") != "1") {
      PreferenceManager().setPref("isLogin", "0");
      PreferenceManager().setPref("usertype", "0");
    }

    String isLoginString = await PreferenceManager().getPref("isLogin");

    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (context) => new Example(
               // isLogin: isLoginString,
              )
    ));
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 17.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,

      pages: [
        PageViewModel(
          title: "Introduction",
          body:
          "Klzstone is a fictional term that doesn't have any recognized meaning or context in the real world as of my last update in January 2022. If it's a term from a specific context like a book, movie, game, or any other fictional setting, please provide more details so I can assist you better.",
          image: Image(
            image: AssetImage('assets/logo.jpeg',),
            fit: BoxFit.contain, width: double.infinity,height: 250,
          ),
          //_buildImage('logo.jpeg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Modern kitchen",
          body: "Klzstone is likely a modern kitchen material, possibly a brand or type of stone used for countertops or other surfaces. It's known for its durability, aesthetic appeal, and ease of maintenance, similar to other materials commonly used in contemporary kitchens like quartz or granite.",
          image: Image(
            image: AssetImage(
              'assets/kit4.jpg',
            ),
            fit: BoxFit.contain,height: double.infinity,width: double.infinity,
          ),
          //_buildImage('img2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Bathrooms",
          body:
          "Luxurious, custom-made bathrooms boast high-end materials, bespoke designs, spa-like features, and personalized touches, providing an exclusive retreat with premium finishes and indulgent amenities.",
          image: Image(
            image: AssetImage(
              'assets/bathroom.jpg',
            ),
            fit: BoxFit.contain,height: double.infinity,width: double.infinity,
          ),

          //_buildImage('img3.jpg'),MarbleBathroom.jpg
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Exquisite Stones",
          body:
          "Granite: Durable, beautiful, and versatile stone. Ideal for kitchens and bathrooms due to its heat resistance, scratch resistance, and variety of colors. A timeless choice for luxurious and custom-designed spaces.",
          image: Image(
            image: AssetImage(
              'assets/kit5.jpg',
            ),
            fit: BoxFit.contain,height: double.infinity,width: double.infinity,
          ),

          //_buildImage('img3.jpg'),MarbleBathroom.jpg
          decoration: pageDecoration,
        ),
      ],
      onDone: () => checkFirstSeen(),
         // _onIntroEnd(context),
      onSkip: () => checkFirstSeen(),
          //_onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back,color: Colors.white,),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white)),
      next: const Icon(Icons.arrow_forward,color: Colors.white),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),activeColor: Colors.white38,
        color: Colors.white,
        //Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({key});

  void _onBackToIntro(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnBoardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("This is the screen after Introduction"),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _onBackToIntro(context),
              child: const Text('Back to Introduction'),
            ),
          ],
        ),
      ),
    );
  }
}