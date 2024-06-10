import 'package:KLZStone/Enums/ViewState.dart';
import 'package:KLZStone/Services/ApiManager.dart';
import 'package:KLZStone/utils/UtilsFile/Logger.dart';
import 'package:KLZStone/utils/UtilsFile/Utils.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/common.dart';
import 'Drawer/drawer.dart';
import 'Nav/NavToNewPageBottomNav.dart';
import 'home_page.dart';
import 'login_page.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({key});

  @override
  State<ContactUsScreen> createState() => _DistributorState();
}

class _DistributorState extends State<ContactUsScreen> {

  ViewStateEnum _state = ViewStateEnum.idle;
  ViewStateEnum get state => _state;

  void setLoaderState(ViewStateEnum viewState) {
    if (state != viewState) _state = viewState;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   update();
      return;
    });

  }

  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController MessageController = TextEditingController();
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
              tooltip: 'back Icon',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Example(
                      //  isLogin: myLogin,
                    )));
                //Navigator.pop(context); Navigator.pop(context);
                },
            ),
          ], //<Widget>[]
        ),
        drawer: DrawerScreen(),
     //   bottomNavigationBar: Example(),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 7.0, right: 7.0, top: 25.0),
            child: Card(color: Colors.black12,shadowColor: Colors.white,surfaceTintColor: Colors.white38,elevation: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //elevation: 2,
                // margin: EdgeInsets.all(19),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('Send us a message',
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                      Divider(color: Colors.white,thickness: 0.5),
                      Container(
                          margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                          child: TextField(
                            controller: NameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'User Name',
                            ),
                          )
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                          child:
                          TextField(
                            controller: EmailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          )
                      ),
                      Container(
                         // height: 100,
                          margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                          child: TextField(
                             controller: MessageController,
                            minLines: 2, // Set this
                            maxLines: 5, // and this
                            keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter a message',
                                )
                          )
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),),
                          // Divider(),
                          ElevatedButton(
                            onPressed: (){
                              contactUsUser();
                              FocusScope.of(context).focusedChild?.unfocus();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.green,
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(1))),
                            ),
                            child: Text('Submit '),
                          ),

                          Divider(color: Colors.white,thickness: 0.5,),
                          SizedBox(height: 8,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
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
                                            color: Colors.white,
                                            fontFamily: "Futura",
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: GestureDetector(
                              onTap: () {
                                _makePhoneCall("1 (972) 807-6187");
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
                                        "1 (972) 807-6187",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Futura",
                                            fontSize: 18),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),

                        ],
                      ),
                    ],
                  ),
                )
            )
        )
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

  bool isValidInput() {
    String message = "";
    bool isValid;
    if (NameController.text.isEmpty) {
      // showMessageInSnackBar("Please enter a Name", true);
      showSnackBar(context);
      Logger.get().log("name");
      print("testing6");
      isValid = false;
    } else if (EmailController.text.isEmpty) {
      //  showMessageInSnackBar("Please enter a Email", true);
      showSnackBarEmail(context);
      isValid = false;
    } else if (EmailController.text.isNotEmpty &&
        !Utils.isValidateEmail(EmailController.text.toString())) {
      // showMessageInSnackBar(
      //     "${"Please enter a email address"}", true);
      showSnackBarEmailValid(context);
      Logger.get().log("email");
      isValid = false;
    }
    else if (MessageController.text.isEmpty) {
      // showMessageInSnackBar("Please enter a Message", true);
      showSnackBarMes(context);
      isValid = false;
      Logger.get().log("message");
    }    else {
      isValid = true;
    }

    if (message != "") {
      showMessageInSnackBar(message, false);
    }

    return isValid;
  }

  inputValidation(){
    //  bool isValid;
    var myPass = NameController.text;
    var myemail = EmailController.text;
    var position = MessageController.text;

    if (myPass.isEmpty) {
      //  isValid = false;
      showToast("Please enter a Name");
    } else if (myemail.isEmpty) {
      //isValid = false;
      showToast("Please enter a Email");
    } else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(myemail)) {
      showToast("Please enter valid Email Id");
    }else if (position.isEmpty) {
      showToast("Please enter a Message");
    } else {
      showAlertDialog(context);
      // sendRequestRegister(myPass, myemail,mycompnyName, position);
      print("testing2");
      // return isValid;
    }
    // return isValid;

  }
  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        left: 10,
        right: 10,
      ),
      content: Text('Please enter a Name'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.up,
      action: SnackBarAction(
        backgroundColor: Colors.black,
        label: 'Dismiss',
        //  disabledTextColor: Colors.white,
        textColor: Colors.white,
        onPressed: () {
          //Do whatever you want
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void showSnackBarEmail(BuildContext context) {
    final snackBar = SnackBar(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        left: 10,
        right: 10,
      ),
      content: Text('Please enter a Email'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.up,
      action: SnackBarAction(
        backgroundColor: Colors.black,
        label: 'Dismiss',
        //  disabledTextColor: Colors.white,
        textColor: Colors.white,
        onPressed: () {
          //Do whatever you want
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void showSnackBarEmailValid(BuildContext context) {
    final snackBar = SnackBar(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        left: 10,
        right: 10,
      ),
      content: Text('Please enter a Valid Email'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.up,
      action: SnackBarAction(
        backgroundColor: Colors.black,
        label: 'Dismiss',
        //  disabledTextColor: Colors.white,
        textColor: Colors.white,
        onPressed: () {
          //Do whatever you want
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void showSnackBarMes(BuildContext context) {
    final snackBar = SnackBar(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        left: 10,
        right: 10,
      ),
      content: Text('Please enter a Message'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.up,
      action: SnackBarAction(
        backgroundColor: Colors.black,
        label: 'Dismiss',
        //  disabledTextColor: Colors.white,
        textColor: Colors.white,
        onPressed: () {
          //Do whatever you want
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showMessageInSnackBar(String message, bool isError) {
    print("showtesting not working");
    try {
      Get.snackbar(
        "",
        "",
        isDismissible: true,
        maxWidth: double.infinity,
        padding: const EdgeInsets.all(3),

        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        //margin: const EdgeInsets.all(3),
        backgroundColor: isError ? Colors.red : Colors.green,
        //   isError ? AppColors.errorColor.withOpacity(.5) : AppColors.successColor,
        colorText: Colors.white,
        titleText: Text(
          message,

          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,

          ),
        ),
      );
    } catch (e) {
      Fimber.e(e.toString());
    }
  }

  void contactUsUser() {
    print("testing");
    contactUsUserApiCall();
  }

  void contactUsUserApiCall() {
    print("testing1");
    //isValidInput();
    if (isValidInput()) {
      print("testing2");
      setLoaderState(ViewStateEnum.busy);
      try {
        print("testing3");
        Logger.get().log("adddepartmet>>>${EmailController}");
        ApiManager.get()
            .contactUsUser(NameController.text, EmailController.text.trim(), MessageController.text,)
            .then((response) async {
          if (response.isOk() && response.body.isSuccess()) {
            setLoaderState(ViewStateEnum.idle);
            // showMessageInSnackBar(response.body.getMessage(), false);
            //  showMessageInSnackBar(response.body.getMessage(), false);
            SnackBar(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 100,
                left: 10,
                right: 10,
              ),
              content: Text(response.body.getMessage()),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.up,
              action: SnackBarAction(
                backgroundColor: Colors.black,
                label: 'Dismiss',
                //  disabledTextColor: Colors.white,
                textColor: Colors.white,
                onPressed: () {
                  //Do whatever you want
                },
              ),
            );
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);

          } else {
            setLoaderState(ViewStateEnum.idle);
            // showMessageInSnackBar(response.body.getMessage(), false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content:  Text(response.body.getMessage()),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 100,
                  left: 20,
                  right: 20,
                ),
              ),
            );
          }

        });
      } catch (e) {
        setLoaderState(ViewStateEnum.idle);
        Logger.get().log(e);
      }
    }
  }

}
