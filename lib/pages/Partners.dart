import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Drawer/drawer.dart';
import 'Nav/NavToNewPageBottomNav.dart';

class Partners extends StatefulWidget {
  const Partners({key});

  @override
  State<Partners> createState() => _PartnersState();
}

class _PartnersState extends State<Partners> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "KLZ Stone",
            style: TextStyle(fontFamily: 'Futura', color: Colors.white),),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            //  icon: const Icon(Icons.arrow_back_rounded),
            tooltip: 'back Icon',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Example(
                    //  isLogin: myLogin,
                  )));
              //Navigator.pop(context); Navigator.pop(context);
            },
          ),
        ],
      ),
      drawer: DrawerScreen(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
         //   crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 300,
                  height: 200,
                  padding: new EdgeInsets.all(10.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // color: Colors.red,
                    elevation: 10,
                    child: InkWell(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            leading: Image(
                              image: AssetImage(
                                'assets/NTFSA.png',
                              ),
                              fit: BoxFit.contain,
                              height: 80,
                              width: 60,
                            ),
                            title: Text(
                                'North Texas Stone Fabricators Association',
                                style: TextStyle(fontSize: 22.0)),
                          ),
                        ],
                      ),
                      onTap: () {
                        //  launchURL('https://www.google.com');
                      },
                    ),
                  ),
                ),
              ),
              Center(
              child: Container(
              width: 300,
              height: 200,
              padding: new EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
               // color: Colors.red,
                elevation: 10,
                child: InkWell(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Image(image: AssetImage(
                    'assets/MIA-logo.jpg',
                  ),fit:BoxFit.contain,height: 100,width: 100,),
                        title: Text(
                            'Natural Stone Institute',
                            style: TextStyle(fontSize: 22.0)
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    print("tapped1");
                  },
                ),
              ),
              ),
            ),
              Center(
                child: Container(
                  width: 300,
                  height: 200,
                  padding: new EdgeInsets.all(10.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // color: Colors.red,
                    elevation: 10,
                    child: InkWell(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            leading: Image(
                              image: AssetImage(
                                'assets/asid-logo.webp',
                              ),
                              fit: BoxFit.cover,
                              height: 100,
                              width: 80,
                            ),
                            title: Text(
                                'American Society of Interior Designers',
                                style: TextStyle(fontSize: 22.0)),
                          ),
                        ],
                      ),
                      onTap: () {
                        print("tapped2");
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}