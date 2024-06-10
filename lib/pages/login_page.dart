import 'dart:convert';
import 'package:KLZStone/pages/Nav/NavToNewPageBottomNav.dart';
import 'package:KLZStone/model/loginModel.dart';
import 'package:KLZStone/utils/PreferenceManager.dart';
import 'package:KLZStone/utils/api_constants.dart';
import 'package:KLZStone/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Enums/ViewState.dart';
import '../Services/ApiManager.dart';
import '../utils/UtilsFile/Logger.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  final ValueChanged<int>? onSelectedChanged;

  const LoginPage({Key? key, this.onSelectedChanged}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();

  ViewStateEnum _state = ViewStateEnum.idle;
  ViewStateEnum get state => _state;

  void setLoaderState(ViewStateEnum viewState) {
    if (state != viewState) _state = viewState;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   update();
      return;
    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // this is the block you need
          String isLoginString = await PreferenceManager().getPref("isLogin");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Example(
                          //isLogin: isLoginString
                      )),
              (route) => false);
          return Future.value(false);
        },
        child: Stack(
          children: <Widget>[
            Positioned.fill(child: _loginWidget(context)),
            // Positioned(
            //   bottom: 30,
            //   right: 0,
            //   // bottom: 40,
            //   // right: 130,
            //   child: InkWell(
            //       child: Container(
            //         alignment: Alignment.centerLeft,
            //         margin: EdgeInsets.only(top: 20),
            //         child: Container(
            //           padding: EdgeInsets.only(
            //               left: 20, top: 10, bottom: 10, right: 30),
            //           child: Chip(
            //             avatar: CircleAvatar(
            //               backgroundColor:
            //                   Theme.of(context).colorScheme.secondary,
            //               child: Icon(
            //                 Icons.arrow_forward,size: 15,
            //                 color: Colors.white,
            //               ),
            //             ),
            //             label: Text('Skip'),
            //           ),
            //         ),
            //       ),
            //       onTap: () async {
            //         String myLogin =
            //             await PreferenceManager().getPref("isLogin");
            //
            //         PreferenceManager().setPref("usertype", "0");
            //         /* Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(
            //             builder: ((context) => Example(
            //                   isLogin: myLogin,
            //                 ))),
            //         (Route<dynamic> route) => false);*/
            //
            //         Navigator.of(context).push(MaterialPageRoute(
            //             builder: (BuildContext context) => Example(
            //                   isLogin: myLogin,
            //                 )));
            //       }
            //       ),
            // )
          ],
        ));
  }

  Widget _loginWidget(context) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20.0),
          alignment: Alignment.centerRight,
          child:
          Card(
            color:  Colors.blue,
            elevation: 5,
            margin: EdgeInsets.only(left: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50)),
            ),
            child: InkWell(
              // onTap: () {
              //   setState(() {
              //     widget.onSelectedChanged!(1);
              //   });
              // },
                    onTap: () async {
                      String myLogin =
                          await PreferenceManager().getPref("isLogin");

                      PreferenceManager().setPref("usertype", "0");

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Example(
                              //  isLogin: myLogin,
                              )));
                    },

              child: Container(
                padding: EdgeInsets.only(
                    left: 20, top: 10, bottom: 10, right: 30),
                child: Text(
                  "Skip",
                  style: new TextStyle(
                      fontFamily: 'Futura',
                      color: Colors.white,
                      fontSize: 24),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 200,
          padding: EdgeInsets.only(bottom: 20),
          alignment: Alignment.bottomCenter,
          child: Text(
            "Login",
            style: TextStyle(
                fontFamily: 'Futura', color: Colors.black, fontSize: 35),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 40),
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  margin: EdgeInsets.only(left: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 30),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _userNameController,
                          style: new TextStyle(fontFamily: 'Futura'),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                             // labelText: "Username or Email",
                              labelText: "Email",
                              icon: Icon(Icons.supervised_user_circle)),
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey[100],
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          style: TextStyle(fontFamily: 'Futura'),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "Password",
                              icon: Icon(Icons.lock)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Positioned.fill(
              //   child: Align(
              //     alignment: Alignment.centerRight,
              //     child: Container(
              //       margin: EdgeInsets.only(right: 10),
              //       alignment: Alignment.centerRight,
              //       ///Oval button
              //       child: ClipOval(
              //         child: Container(
              //           decoration: BoxDecoration(
              //               gradient: LinearGradient(
              //                   begin: Alignment.topLeft,
              //                   end: Alignment.bottomRight,
              //                   colors: [Colors.green, Colors.blue])),
              //           child: InkWell(
              //             splashColor: Colors.red, // inkwell color
              //             child: SizedBox(
              //                 width: 50,
              //                 height: 50,
              //                 child: Icon(
              //                   Icons.arrow_forward,
              //                   color: Colors.white,
              //                 )),
              //             onTap: () {
              //               var myPass = _passwordController.text;
              //               var myUser = _userNameController.text;
              //
              //               if (myUser.isEmpty) {
              //                 showToast("Please enter Email");
              //               } else if (myPass.isEmpty) {
              //                 showToast("Please enter Password");
              //               } else if (!RegExp(
              //                       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              //                   .hasMatch(myUser)) {
              //                 showToast("Please enter valid Email Id");
              //               } else {
              //                 showAlertDialog(context);
              //                 sendRequest(myUser, myPass);
              //               }
              //
              //               /*Navigator.pushAndRemoveUntil(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: ((context) => HomePage())),
              //                   (Route<dynamic> route) => false);*/
              //             },
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 20),
          child: Card(
            color: Colors.blue,
            elevation: 5,
            margin: EdgeInsets.only(left: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
            child: InkWell(
              // onTap: () {
              //   setState(() {
              //     widget.onSelectedChanged!(0);
              //   });
              // },
              onTap: () {
                var myPass = _passwordController.text;
                var myUser = _userNameController.text;

                if (myUser.isEmpty) {
                  showToast("Please enter Email");
                } else if (myPass.isEmpty) {
                  showToast("Please enter Password");
                } else if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(myUser)) {
                  showToast("Please enter valid Email Id");
                } else {
                  showAlertDialog(context);
                  sendRequest(myUser, myPass);
                }
              },
              child: Container(
                padding:
                EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 30),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontFamily: 'Futura',
                      color: Colors.white,
                      fontSize: 24),
                ),
              ),
            ),
          ),
          // Card(
          //   color:  Colors.blue,
          //   elevation: 5,
          //   margin: EdgeInsets.only(left: 0),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(50),
          //         bottomLeft: Radius.circular(50)),
          //   ),
          //   child: InkWell(
          //     onTap: () {
          //       // setState(() {
          //       //   widget.onSelectedChanged!(1);
          //       // });
          //
          //       var myPass = _passwordController.text;
          //       var myUser = _userNameController.text;
          //
          //       if (myUser.isEmpty) {
          //         showToast("Please enter Email");
          //       } else if (myPass.isEmpty) {
          //         showToast("Please enter Password");
          //       } else if (!RegExp(
          //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          //           .hasMatch(myUser)) {
          //         showToast("Please enter valid Email Id");
          //       } else {
          //         showAlertDialog(context);
          //         sendRequest(myUser, myPass);
          //       }
          //     },
          //     child: Container(
          //       padding: EdgeInsets.only(
          //           left: 20, top: 10, bottom: 10, right: 30),
          //       child: Text(
          //         "Login",
          //         style: new TextStyle(
          //             fontFamily: 'Futura',
          //             color: Colors.white,
          //             fontSize: 24),
          //       ),
          //     ),
          //   ),
          // ),
          // Card(
          //   color: Colors.white,
          //   elevation: 5,
          //   margin: EdgeInsets.only(left: 0),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.only(
          //         topRight: Radius.circular(50),
          //         bottomRight: Radius.circular(50)),
          //   ),
          //   child: InkWell(
          //     onTap: () {
          //       setState(() {
          //         widget.onSelectedChanged!(0);
          //       });
          //     },
          //     child: Container(
          //       padding:
          //           EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 30),
          //       child: Text(
          //         "Register",
          //         style: TextStyle(
          //             fontFamily: 'Futura',
          //             color: Colors.deepOrange[200],
          //             fontSize: 24),
          //       ),
          //     ),
          //   ),
          // ),
        ),
        SizedBox(height: 20,),
        Row(
          children: <Widget>[
            const Text('Does not have account?',style: TextStyle(fontSize: 14)),
            SizedBox(width: 5,),
            GestureDetector(
              onTap: (){
                      setState(() {
                        widget.onSelectedChanged!(0);
                      });
              },
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 16,color: Colors.blue),
                ),
            )
            // TextButton(
            //   child: const Text(
            //     'Register',
            //     style: TextStyle(fontSize: 16,color: Colors.blue),
            //   ),
            //   onPressed: () {
            //       setState(() {
            //         widget.onSelectedChanged!(0);
            //       });
            //   },
            // )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    );
  }

  sendRequest(String email, String password) async {
    var data = {"email": "$email", "password": "$password"};

    var url = '${ApiConstants.baseURl}quartz/public/api/auth/loginUser';
    // Map<String, dynamic> body = {'?email': email, '&password': password};
    // var bodyEncoded = json.encode(body);

  //  http.post(Uri.parse(url),body: {"email": "?email", "password": "&password"}).then((response) async {
    http.post(Uri.parse(url),body: data).then((response) async {
     // print("Response status: ${response.statusCode}");
    //  https://insigniatechnolabs.com/quartz/public/api/auth/loginUser?email=qwe@gmail.com&password=123456
      print("testing1");
      //   showToast(response.statusCode.toString());
      print("Response status: ${response.statusCode}");
      print("Response status: ${response.statusCode}");
      print("Response data: ${data}");
      print("Response url: ${url}");
      print("Response urldata: ${url}$data");

    //   if (response.statusCode == 200) {
    //     var jsonResponse = json.decode(response.body);
    //     String msg = jsonResponse["msg"];
    //
    //     showToast(msg);
    //     Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(builder: ((context) => Example())),
    //             (Route<dynamic> route) => false);
    // //  }
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        LoginModel model = LoginModel.fromJson(jsonResponse["data"]);
        PreferenceManager().setPref("email", model.email ?? '');
        PreferenceManager().setPref("username", model.username ?? '');
        PreferenceManager().setPref("usertype", model.usertype ?? '');
        PreferenceManager().setPref("isLogin", "1");

        String myLogin = await PreferenceManager().getPref("isLogin");

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: ((context) => HomePage(
                    //  isLogin: myLogin,
                    ))),
            (Route<dynamic> route) => false);
      } else if (response.statusCode == 400) {
        Navigator.pop(context, true);
        showToast("email or password wrong!!");
      } else if (response.statusCode == 422) {
        Navigator.pop(context, true);
        showToast("Enter Email or Password Fields!!");
      }
    });
  }

  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 50), child: Text("Loading")),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


