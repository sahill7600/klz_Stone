import 'package:KLZStone/pages/fullscreen_map.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 80, left: 20, right: 20),
        child: Column(
      
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image: AssetImage(
                'assets/logo.jpeg',
              ),
              fit: BoxFit.contain,
              width: 150,
              height: 150,
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "About Us : ",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Futura", fontSize: 18),
                  ),
                  Expanded(
                    child: Text(
                      "KLZ Stone Supply is the premier stone distributor in the Dallas/Fort Worth metro area. KLZ Stone Supplies carries the largest inventory in the region, with over 30,000 slabs of Granite, Marble, Quartzite, Travertine, Onyx, Quartzmasters, and Limestone from around the world. KLZ Stone Supply, and its parent company, KLZ Diamond Tools, is the only supplier who can offer a one-stop shop for Fabricators, Designers, Builders, and Architects.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Futura",
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _makeEmail("info@klzstone.com");
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.mail,
                        ),
                        SizedBox(width: 15),
                        Text(
                          "info@klzstone.com",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Futura",
                              fontSize: 18),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GestureDetector(
                onTap: () {
                  _makePhoneCall("1877-559-3232");
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.call,
                        ),
                        SizedBox(width: 15),
                        Text(
                          "1877-559-3232",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Futura",
                              fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FullScreenMap()),
                  );
                },
                child: Text(
                  "Contact Us",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white, fontFamily: "Futura", fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: StadiumBorder(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _makeEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }
}
