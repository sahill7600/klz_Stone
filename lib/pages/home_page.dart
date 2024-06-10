import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:KLZStone/pages/Nav/NavToNewPageBottomNav.dart';
import 'package:KLZStone/model/listModel.dart';
import 'package:KLZStone/pages/loginfirstpage.dart';
import 'package:KLZStone/pages/webview.dart';
import 'package:KLZStone/utils/PreferenceManager.dart';
import 'package:KLZStone/utils/api_constants.dart';
import 'package:KLZStone/utils/common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'Drawer/drawer.dart';

class HomePage extends StatefulWidget {
 // final String isLogin;
//  HomePage({required this.isLogin});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BaseCacheManager baseCacheManager = DefaultCacheManager();
  List<ListModel> data = <ListModel>[];
  List<ListModel> filterList = <ListModel>[];
  var _isSearch = false;

  @override
  Widget build(BuildContext context) {
    String isLoginLocal = "";

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
            TextButton(onPressed: (){
              Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => LoginFirstPage())));
            },
              child:Text("Login", style: TextStyle(
                                    fontFamily: 'Futura',
                                    color: Colors.white,
                                    fontSize: 15)),)//IconButton
          ], //<Widget>[]
             elevation: 50.0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        drawer: DrawerScreen(),
     //    bottomNavigationBar: Example(),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              child: new TextField(
                onChanged: (text) {
                  if (text.isNotEmpty && text.length > 1) {
                    setState(() {
                      _isSearch = true;
                      filterList.clear();
                      data.forEach((element) {
                        if (element.item_name!
                            .toLowerCase()
                            .contains(text.toLowerCase())) {
                          filterList.add(element);
                        }
                      });
                    });
                  } else {
                    setState(() {
                      _isSearch = false;
                    });
                  }
                },
                decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(180.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: "Search here",
                    fillColor: Colors.white70),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            dynamicView()
          ],
        ));
  }

  _logoutApp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Do you want to Logout ?'),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('No'),
          ),
          MaterialButton(
            onPressed: () async {
              PreferenceManager().remove();

              if (await PreferenceManager().getPref("isLogin") != "1") {
                PreferenceManager().setPref("isLogin", "0");
                PreferenceManager().setPref("usertype", "0");
              }
              String isLoginString =
                  await PreferenceManager().getPref("isLogin");

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => Example(
                          //  isLogin: isLoginString,
                          ))),
                  (Route<dynamic> route) => false);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<List<ListModel>>? _fetchJobs() async {
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      _showDialog('No internet', "You're not connected to a network");
      throw Exception('No Internet Connection');
    } else {
      print("Fetch ProductList Data ............");
      final jobsListAPIUrl =
          '${ApiConstants.baseURl}quartz/public/api/productsList';
      final response = await http.get(
        Uri.parse(jobsListAPIUrl),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
      );
      print("Fetch ProductList  :::::  " + response.statusCode.toString());
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        var jsonResponse = json.decode(response.body);
        List listdata = jsonResponse["data"];

        print(listdata);

        return listdata.map((job) => new ListModel.fromJson(job)).toList();
      } else if (response.statusCode == 400) {
        var jsonResponse = json.decode(response.body);
        throw Exception(jsonResponse["msg"]);
      } else if (response.statusCode == 401) {
        String email = await PreferenceManager().getPref("email");
        String password = await PreferenceManager().getPref("password");
        throw Exception('User Unauthorised');
      } else {
        throw Exception('Failed to load jobs from API');
      }
    }
  }

  ListView _jobsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            child: new Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    bottom: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // add this
                    children: <Widget>[
                      /* Image.asset(data[index].file_name, height: 200, fit: BoxFit.fill),*/
                      InkWell(
                        child: CachedNetworkImage(
                          cacheManager: baseCacheManager,
                          height: 200,
                          fit: BoxFit.fill,
                          imageUrl: data[index].file_name,
                          errorWidget: (context, url, error) {
                            return Center(
                                child: Image.asset(
                              'assets/placeholder_image.png',
                            ));
                          },
                          placeholder: (context, url) => new Align(
                            alignment: Alignment.center,
                            child: Center(
                              child: Container(
                                height: 30,
                                width: 30,
                                margin: EdgeInsets.all(85),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          var selectedProductId = data[index].product_id;
                          var productName = data[index].item_name;
                          print("=--==-=-=-=-=-===-=-=-==-=-=-=-=-=-=-" +
                              productName);
                          String usertype =
                              await PreferenceManager().getPref("usertype");
                          print(usertype);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => MyWebView(
                                  title: productName,
                                  selectedUrl: "https://klzstone.com")));
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              child: Icon(Icons.file_download),
                              onTap: () {
                                saveImage(data[index].file_name,
                                    data[index].item_name);
                              },
                            ),
                            InkWell(
                              child: Icon(Icons.share),
                              onTap: () async {
                                if (data[index].file_name != null &&
                                    data[index].file_name.isNotEmpty) {
                                  baseCacheManager
                                      .getFile(data[index].file_name)
                                      .first
                                      .then((info) {
                                    Share.shareXFiles([XFile(info.file.path)],
                                        subject: 'Share',
                                        text: data[index].item_name);
                                    // info.file.readAsBytes().then((bytes) {
                                    //   Share.shareWithResult(
                                    //       sharePopupTitle: 'share',
                                    //       fileName: 'share.jpeg',
                                    //       text: data[index].item_name,
                                    //       mimeType: 'image/jpeg',
                                    //       bytesOfFile: bytes);
                                    // });
                                  });
                                } else {
                                  showToast(
                                      'Image not available. Not able to share the image');
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                        child: Text(
                          data[index].item_name,
                          style: TextStyle(
                              fontFamily: 'Futura', color: Colors.grey[500]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                        child: Text(
                          data[index].item_name,
                          style: TextStyle(
                              fontFamily: 'Futura',
                              color: Colors.black,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  dynamicView() {
    return FutureBuilder<List<ListModel>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.data != null && snapshot.hasData) {
          data = snapshot.data!;
          return Expanded(
              child: Center(
                  child: _isSearch && filterList.isEmpty
                      ? Text("No Data Found !!")
                      : _jobsListView(_isSearch ? filterList : data)));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Expanded(child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  saveImage(String? imageUrl, itemName) async {
    try {
      if (imageUrl != null && imageUrl.isNotEmpty) {
        showToast('Downloading $itemName');
        // Download image
        final response = await http.get(Uri.parse(imageUrl));

        // Get temporary directory
        final dir = await getTemporaryDirectory();

        final imageName = imageUrl.split('/').last;

        // Create an image name
        var filename = '${dir.path}/$imageName';

        // Save to filesystem
        final file = File(filename);
        await file.writeAsBytes(response.bodyBytes);
        showToast('Downloaded $itemName');
      } else {
        showToast('Image not available. Not able to download the image ');
      }
    } on PlatformException catch (error) {
      print('Error: $error');
    }
  }

  _showDialog(title, text) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              MaterialButton(
                child: Text('Ok'),
                onPressed: () {
                  exit(0);
                },
              )
            ],
          );
        });
  }
}
