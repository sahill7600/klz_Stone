import 'package:KLZStone/widgets/login_bg.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'registration_page.dart';

class LoginFirstPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'Flutter Demo Home Page');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int item = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            LoginBg(),
            item == 1
                ? LoginPage(
                    onSelectedChanged: ((value) {
                      print(value);
                      setState(() {
                        item = value;
                      });
                    }),
                  )
                : RegistrationPage(
                    onSelectedChanged: ((value) {
                      setState(() {
                        item = value;
                      });
                    }),
                  ),
          ],
        ),
      ),
    );
  }
}
