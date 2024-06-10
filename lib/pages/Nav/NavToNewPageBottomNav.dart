import 'package:KLZStone/pages/detail_page.dart';
import 'package:KLZStone/pages/gallerylistpage.dart';
import 'package:KLZStone/pages/home_page.dart';
import 'package:KLZStone/pages/locationpage.dart';
import 'package:KLZStone/pages/promotionpage.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';


class Example extends StatefulWidget {

  @override
  ExampleState createState() => new ExampleState();
}

class ExampleState extends State<Example> {
  int currentTab = 0; // Index of currently opened tab.

  MapPage locationPage = new MapPage();
  GalleryListPage aboutUs = new GalleryListPage(); // Page that corresponds with the third tab.
  PromotionScreen promotionScreen = new PromotionScreen();
  DetailPage Detail = new DetailPage();List<Widget> pages = <Widget>[]; // List of all pages that can be opened from our BottomNavigationBar.
  // Index 0 represents the page for the 0th tab, index 1 represents the page for the 1st tab etc...
  Widget currentPage =HomePage();

    //  DetailPage(); // Setting the first page that we'd like to show our user.; // Page that is open at the moment.
  bool dummyDisplay = true;

  @override
  void initState() {
    super.initState();
    pages = [
     // HomePage(isLogin: widget.isLogin!),
      HomePage(),
      locationPage,
      aboutUs,
      promotionScreen,
      Detail

    ];
   }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Here we create our BottomNavigationBar.
    final BottomNavigationBar navBar = new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: !dummyDisplay ? Colors.white : Colors.grey,
      selectedLabelStyle: TextStyle(fontFamily: "Futura"),
      unselectedLabelStyle: TextStyle(fontFamily: "Futura"),
      unselectedItemColor: Colors.grey,
      currentIndex: currentTab,
      // Our currentIndex will be the currentTab value. So we need to update this whenever we tab on a new page!
      onTap: (int numTab) {
        // numTab will be the index of the tab that is pressed.
        setState(() {
          // Setting the state so we can show our new page.
          dummyDisplay = false;
          print("Current tab: " +
              numTab.toString()); // Printing for debugging reasons.
          currentTab =
              numTab; // Updating our currentTab with the tab that is pressed [See 43].
          currentPage = pages[
              numTab]; // Updating the page that we'd like to show to the user.
        });
      },
      items: <BottomNavigationBarItem>[
        // Visuals, see docs for more information: https://docs.flutter.io/flutter/material/BottomNavigationBar-class.html
        new BottomNavigationBarItem(
            //numTab 0
            icon: new Icon(Icons.home),
            label: "Live Inventory"),
        new BottomNavigationBarItem(
            //numTab 1
            icon: new Icon(Icons.location_on),
            label: "Location"),
        new BottomNavigationBarItem(
            //numTab 2
            icon: new Icon(Icons.image),
            label: "Gallery"),
        new BottomNavigationBarItem(
            //numTab 1
            icon: new Icon(Icons.graphic_eq),
            label: "Promotion"),
        new BottomNavigationBarItem(
            //numTab 1
            icon: new Icon(Icons.account_box_outlined),
            label: "About Us")
      ],
    );

    return WillPopScope(
        onWillPop: () async {
          _exitApp(context);

          return Future.value(false);
        },
        child: Scaffold(
          bottomNavigationBar: navBar,
          //some widget ) ,
          body: currentPage, // The body will be the currentPage. Which we update when a tab is pressed.
        ));
  }

  _exitApp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Do you want to Exit from App ?'),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('No'),
          ),
          MaterialButton(
            onPressed: () async {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}
