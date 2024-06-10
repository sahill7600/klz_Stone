import 'package:KLZStone/pages/Nav/NavToNewPageBottomNav.dart';
import 'package:KLZStone/pages/Partners.dart';
import 'package:KLZStone/pages/aboutUs.dart';
import 'package:KLZStone/pages/contactUs.dart';
import 'package:KLZStone/pages/gallerylistpage.dart';
import 'package:KLZStone/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({key});

  @override
  State<DrawerScreen> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black,
                ),
                accountName: Text(
                  "KLZ Stone",
                  style: TextStyle(fontSize: 24,fontFamily: 'Futura',),
                ),
                accountEmail: Text("info@klzstone.com"),
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(' Home '),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => Example(
                   //       isLogin: '',
                        ))));
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text(' Gallery '),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => GalleryListPage())));
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_phone_outlined),
              title: const Text(' Contact Us '),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => ContactUsScreen())));
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_box_outlined),
              title: const Text(' About Us '),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => AboutUsScreen())));
              },
            ),
            ListTile(
              leading: const Icon(Icons.handshake_outlined),
              title: const Text('Our Partners '),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => Partners())));
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.logout),
            //   title: const Text('LogOut'),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        ),
      );
  }
}
