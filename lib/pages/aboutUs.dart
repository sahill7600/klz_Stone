import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Drawer/drawer.dart';
import 'Nav/NavToNewPageBottomNav.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
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
        )], //<Widget>[]
        ),
        drawer: DrawerScreen(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  child: Image(
                    image: AssetImage(
                      'assets/logo.jpeg',
                    ),
                    fit: BoxFit.contain,
                    // width: 150,
                    // height: 150,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child:
                  Text(
                    "KLZ Stone Supply is the premier stone distributor in the Dallas/Fort Worth metro area. KLZ Stone Supplies carries the largest inventory in the region, with over 30,000 slabs of Granite, Marble, Quartzite, Travertine, Onyx, Quartzmasters, and Limestone from around the world. KLZ Stone Supply, and its parent company, KLZ Diamond Tools, is the only supplier who can offer a one-stop shop for Fabricators, Designers, Builders, and Architects.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Futura",
                        fontSize: 14),
                  ),
          
                ),
              //  SizedBox(height: 10),
                horizontalList
          
                  ],
            ),
          ),
        ),
      )

    );
  }
  Widget horizontalList = new Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 200.0,
     // width: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 300,
            padding: new EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            //  color: Colors.orange,
              color: const Color(0xffF97352),
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              //  mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(CupertinoIcons.umbrella_fill,size: 28,color: Colors.white,),
               //   Icon(Icons.umbrella_fill,size: 28,color: Colors.white,),
                  SizedBox(height: 5,),
              Text("OUTSTANDING SUPPORT", style: TextStyle(
                  fontFamily: 'Futura',
                  color: Colors.white,
                  fontSize: 20
              ),),
                  SizedBox(height: 5,),
              Text("We strive to deliver great products.",style: TextStyle(
                  fontFamily: 'Futura',
                  color: Colors.white,
                  fontSize: 16
              ),)
                ],
              ),
            ),

          ),
        //  SizedBox(width: 2,),
          Container(
            width: 300,
            padding: new EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: const Color(0xffF97352),
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //  mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(CupertinoIcons.money_dollar_circle,size: 28,color: Colors.white,),
                  SizedBox(height: 5,),
                  Text("GREAT PRICES", style: TextStyle(
                      fontFamily: 'Futura',
                      color: Colors.white,
                      fontSize: 20
                  ),),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10),
                    child: Text("We offer great product selection at best prices in the industry.",style: TextStyle(
                        fontFamily: 'Futura',
                        color: Colors.white,
                        fontSize: 16
                    ),),
                  )
                ],
              ),
            ),

          ),
       //   SizedBox(width: 2,),
          Container(
            width: 300,
            padding: new EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: const Color(0xffF97352),
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //  mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(CupertinoIcons.paperplane_fill,size: 28,color: Colors.white,),
                  SizedBox(height: 5,),
                  Text("CUSTOMER SERVICE", style: TextStyle(
                      fontFamily: 'Futura',
                      color: Colors.white,
                      fontSize: 20
                  ),),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10),
                    child: Text("knowledgeable customer service techs are available to support your company 24 hours a day",style: TextStyle(
                        fontFamily: 'Futura',
                        color: Colors.white,
                        fontSize: 16
                    ),),
                  )
                ],
              ),
            ),

          ),
       //   SizedBox(width: 2,),
          Container(
            width: 300,
            padding: new EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: const Color(0xffF97352),
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //  mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(CupertinoIcons.umbrella_fill,size: 28,color: Colors.white,),
                  SizedBox(height: 5,),
                  Text("LIKED BY THOUSANDS", style: TextStyle(
                      fontFamily: 'Futura',
                      color: Colors.white,
                      fontSize: 20
                  ),),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10),
                    child: Text("The staff there are truly amazing and can help you with product selection.",style: TextStyle(
                        fontFamily: 'Futura',
                        color: Colors.white,
                        fontSize: 16
                    ),),
                  )
                ],
              ),
            ),

          ),
        ],
      )
  );
}
