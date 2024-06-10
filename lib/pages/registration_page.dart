import 'dart:convert';
import 'package:KLZStone/pages/loginfirstpage.dart';
import 'package:KLZStone/utils/api_constants.dart';
import 'package:KLZStone/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  final ValueChanged<int>? onSelectedChanged;

  const RegistrationPage({Key? key, this.onSelectedChanged}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String dropdownValue = 'Fabricators';
  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _emailController = TextEditingController();
  var _company_nameController = TextEditingController();
  var _positionController = TextEditingController();
  var userType = "1";

  List<String> spinnerItems = [
    'Fabricators',
    'Contractors',
    'Designer & Architect'
  ];

  @override
  Widget build(BuildContext context) {
    return _registerWidget(context);
  }

  Widget _registerWidget(context) {
    return Container(
        margin: const EdgeInsets.only(top: 35),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child:
              Card(
                color: Colors.blue.shade300,
                elevation: 5,
                margin: EdgeInsets.only(left: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50)),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.onSelectedChanged!(1);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 20, top: 10, bottom: 10, right: 30),
                    child: Text(
                      "Login",
                      style: new TextStyle(
                          fontFamily: 'Futura',
                          color: Colors.white,
                          //Colors.deepOrange[300],
                          fontSize: 24),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              padding: EdgeInsets.only(bottom: 20),
              alignment: Alignment.bottomCenter,
              child: Text(
                "Register",
                style: new TextStyle(
                    fontFamily: 'Futura', color: Colors.black, fontSize: 35),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text('Are you a :   ',
                          style: new TextStyle(
                              fontFamily: 'Futura',
                              fontSize: 15,
                              color: Colors.black)),
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: new TextStyle(
                        fontFamily: 'Futura',
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      underline: Container(
                        height: 1,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? data) {
                        setState(() {
                          if (data != null) {
                            dropdownValue = data;
                            if (dropdownValue == "Fabricators") {
                              userType = "1";
                            } else if (dropdownValue == "Contractors") {
                              userType = "2";
                            } else if (dropdownValue ==
                                "Designer & Architect") {
                              userType = "3";
                            }
                          }
                        });
                      },
                      items: spinnerItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Center(child: Text(value)));
                      }).toList(),
                    ),

                    /* Text('Selected Item = ' + '$dropdownValue',
                  style: TextStyle(fontSize: 22, color: Colors.black)),*/
                  ],
                ),
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
                              style: new TextStyle(fontFamily: 'Futura'),
                              controller: _userNameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Username",
                                  icon: Icon(Icons.supervised_user_circle)),
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey[100],
                            ),
                            TextField(
                              style: new TextStyle(fontFamily: 'Futura'),
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Password",
                                  icon: Icon(Icons.lock)),
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey[100],
                            ),
                            TextField(
                              style: new TextStyle(fontFamily: 'Futura'),
                              controller: _emailController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Email",
                                  icon: Icon(Icons.email)),
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey[100],
                            ),
                            TextField(
                              style: new TextStyle(fontFamily: 'Futura'),
                              controller: _company_nameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Company Name",
                                  icon: Icon(Icons.domain)),
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey[100],
                            ),
                            TextField(
                              style: new TextStyle(fontFamily: 'Futura'),
                              controller: _positionController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Position",
                                  icon: Icon(Icons.person)),
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
                  //                   Icons.check,
                  //                   color: Colors.white,
                  //                 )),
                  //             onTap: () {
                  //               var myPass = _passwordController.text;
                  //               var myUserName = _userNameController.text;
                  //               var myemail = _emailController.text;
                  //               var mycompnyName = _company_nameController.text;
                  //               var position = _positionController.text;
                  //
                  //               if (myUserName.isEmpty) {
                  //                 showToast("Please enter UserName");
                  //               } else if (myPass.isEmpty) {
                  //                 showToast("Please enter Password");
                  //               } else if (myemail.isEmpty) {
                  //                 showToast("Please enter Email");
                  //               } else if (!RegExp(
                  //                       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  //                   .hasMatch(myemail)) {
                  //                 showToast("Please enter valid Email Id");
                  //               } else if (mycompnyName.isEmpty) {
                  //                 showToast("Please enter company name");
                  //               } else if (position.isEmpty) {
                  //                 showToast("Please enter position");
                  //               } else {
                  //                 showAlertDialog(context);
                  //                 sendRequestRegister(myUserName, myemail,
                  //                     myPass, userType, mycompnyName, position);
                  //               }
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 20),
                child: Card(
                  color:Colors.blue.shade300,
                  elevation: 5,
                  margin: EdgeInsets.only(left: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                  ),
                  child: InkWell(
                    onTap: () {
                      var myPass = _passwordController.text;
                      var myUserName = _userNameController.text;
                      var myemail = _emailController.text;
                      var mycompnyName = _company_nameController.text;
                      var position = _positionController.text;

                      if (myUserName.isEmpty) {
                        showToast("Please enter UserName");
                      } else if (myPass.isEmpty) {
                        showToast("Please enter Password");
                      } else if (myemail.isEmpty) {
                        showToast("Please enter Email");
                      } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(myemail)) {
                        showToast("Please enter valid Email Id");
                      } else if (mycompnyName.isEmpty) {
                        showToast("Please enter company name");
                      } else if (position.isEmpty) {
                        showToast("Please enter position");
                      } else {
                        showAlertDialog(context);
                        sendRequestRegister(myUserName, myemail,
                            myPass, userType, mycompnyName, position);
                        print("testing2");

                      }
                    },
                    child: Container(
                      padding:
                      EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 30),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontFamily: 'Futura',
                            color: Colors.white,
                            fontSize: 24),
                      ),
                    ),
                  ),
                )

            ),
          ],
        ));
  }

  sendRequestRegister(String username, String email, String password,
      String userType, String company_name, String position) async {
    print("testing3");

    Map data = {
      'username': username,
      'email': email,
      'password': password,
      'usertype': userType,
      'company_name': company_name,
      'position': position
    };

    var url = '${ApiConstants.baseURl}quartz/public/api/auth/registerUser';
    http.post(Uri.parse(url), body: data).then((response) {
      print("testing1");
   //   showToast(response.statusCode.toString());
      print("Response status: ${response.statusCode}");
      print("Response status: ${response.statusCode}");
      print("Response data: ${data}");
      print("Response url: ${url}");
      print("Response urldata: ${url}$data");
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        String msg = jsonResponse["msg"];

        showToast(msg);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: ((context) => LoginFirstPage())),
            (Route<dynamic> route) => false);
      } else if (response.statusCode == 400) {
        Navigator.pop(context, true);
        var jsonResponse = json.decode(response.body);
        String msg = jsonResponse["msg"];
        showToast(msg);
      } else if (response.statusCode == 422) {
        Navigator.pop(context, true);
        showToast("Enter Email or Password Fields!!");
      }
    });
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 50),
            child: Text("Loading",
                style: TextStyle(
                  fontFamily: 'Futura',
                )),
          )
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
}
