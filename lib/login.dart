import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:indusnova/String_Values.dart';
import 'package:indusnova/model.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml2json/xml2json.dart';

import 'model2.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  bool loading = false;
  String errortextemail;
  String errortextpass;
  final Xml2Json xml2Json = Xml2Json();
  bool validateE = false;

  bool validateP = false;

  Model li;

  Model2 li2;
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future<http.Response> postRequest() async {
    setState(() {
      loading = true;
    });
    var envelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xmlns:xsd="http://www.w3.org/2001/XMLSchema"
xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <IndusMobileUserLogin1 xmlns="http://tempuri.org/" >
    <UserName>${emailController.text}</UserName>
    <UserPassword>${passwordController.text}</UserPassword>
    </IndusMobileUserLogin1>
  </soap:Body>
</soap:Envelope>
''';
    var url =
        'http://103.252.117.204:90/Indusssp/service.asmx?op=IndusMobileUserLogin1';
    Map data = {
      "username": emailController.text,
      "password": passwordController.text
    };
//    print("data: ${data}");
//    print(String_values.base_url);

    var response = await http.post(url,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
        },
        body: envelope);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      xml.XmlDocument parsedXml = xml.XmlDocument.parse(response.body);
      print(parsedXml.text);
      final decoded = json.decode(parsedXml.text);
      li2 = Model2.fromJson(decoded[0]);
      print(li2.name);
      if (li2.name != null) {
        Fluttertoast.showToast(
            msg:
                "Name: ${li2.name}\nCode: ${li2.code}\nDepartment: ${li2.depratment}\nBranchCode: ${li2.branchCode}\nBranchName: ${li2.branchName}\nManagerID: ${li2.managerID}\nSuperUser: ${li2.superUser}\nWebIDSales: ${li2.webIDSales}\nImei: ${li2.imei}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      } else
        Fluttertoast.showToast(
            msg: "Please check your login details,No users found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Http error!, Response code ${response.statusCode}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        loading = false;
      });
      print("Retry");
    }
    // print("response: ${response.statusCode}");
    // print("response: ${response.body}");
    return response;
  }

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  static TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Container(
                    //   color: Colors.white,
                    //   height: height/20,
                    //
                    // ),
                    new Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 1.0), //(x,y)
                              blurRadius: 1.0,
                            ),
                          ],
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(width))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'logo.png',
                            width: width / 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: "Solutions ",
                                      style: TextStyle(
                                          color: Colors.red,
                                          shadows: [
                                            Shadow(
                                                color: Colors.blueAccent,
                                                blurRadius: 1,
                                                offset: Offset(0.1, 0.1))
                                          ],
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                    TextSpan(
                                      text: "Pvt ",
                                      style: TextStyle(
                                          color: Colors.green,
                                          shadows: [
                                            Shadow(
                                                color: Colors.grey,
                                                blurRadius: 1,
                                                offset: Offset(0.1, 0.1))
                                          ],
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                    TextSpan(
                                      text: "Ltd",
                                      style: TextStyle(
                                          color: Colors.green,
                                          shadows: [
                                            Shadow(
                                                color: Colors.grey,
                                                blurRadius: 1,
                                                offset: Offset(0.1, 0.1))
                                          ],
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                  ])),
                                ),
                              ),
                              Flexible(
                                child: SizedBox(
                                  width: width / 3,
                                ),
                                flex: 1,
                              ),
                            ],
                          )
                        ],
                      ),
                      width: width,
                      height: height / 3.3,
                    ),

                    SizedBox(
                      height: height / 12,
                    ),
                    buildTextField("Email"),
                    SizedBox(
                      height: height / 30,
                    ),
                    buildTextField("Password"),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: InkWell(
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Forgot Password?"),
                                ),
                                onTap: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    SizedBox(
                      height: height / 30,
                    ),

                    ButtonContainer(),

                    SizedBox(
                      height: height / 30,
                    ),
                    Container(
                      child: Center(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Create an Account",
                              style: TextStyle(
                                  color: String_values.base_color,
                                  fontWeight: FontWeight.w600),
                            ),
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

  Widget buildTextField(String hintText) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 5),
      child: TextField(
        controller: hintText == "Email" ? emailController : passwordController,
        keyboardType: TextInputType.emailAddress,
        onTap: () {
          setState(() {
            hintText == "Email" ? errortextemail = null : errortextpass = null;
          });
        },
        decoration: InputDecoration(
          errorText: hintText == "Email"
              ? validateE
                  ? errortextemail
                  : null
              : validateP
                  ? errortextpass
                  : null,
          prefixIcon:
              hintText == "Email" ? Icon(Icons.email) : Icon(Icons.lock),
          labelText: hintText == "Email" ? hintText + " or Username" : hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          suffixIcon: hintText == "Password"
              ? IconButton(
                  onPressed: _toggleVisibility,
                  icon: _isHidden
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                )
              : null,
        ),
        obscureText: hintText == "Password" ? _isHidden : false,
      ),
    );
  }

  Widget ButtonContainer() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: 50,
        child: FlatButton(
          child: Text('Login'),
          color: String_values.base_color,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          onPressed: () {
            setState(() {
              if (emailController.text.trim().isNotEmpty) {
                validateE = false;
              } else {
                validateE = true;
                errortextemail = "Email cannot be empty";
              }
              if (passwordController.text.isEmpty) {
                if (passwordController.text.isEmpty)
                  errortextpass = "Password cannot be empty";
                validateP = true;
              } else
                validateP = false;

              if (validateE == false && validateP == false)
                check().then((value) {
                  if (value)
                    postRequest();
                  else
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("No Internet Connection"),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                });
            });
          },
        ));
  }
}
