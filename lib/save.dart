import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'show.dart';

String name;
String email;
String contact;
String add;

sendServer(String name, String email, String contact, String add) async {
  bool isValid = EmailValidator.validate(email);
  int phoneNumLen = contact.length;
  if (isValid == true && phoneNumLen == 10 && name != '' && add != '') {
    var response = await http.post(
        Uri.parse('https://dry-bayou-99944.herokuapp.com/profiles'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'name': name,
          'email': email,
          'contact': contact,
          'address': add,
        }));
    Fluttertoast.showToast(
        msg: response.body,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  } else {
    Fluttertoast.showToast(
        msg: "Please check if you have entered the correct info !!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

class MyApp extends StatefulWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  color: Colors.orange.shade300,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/save');
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(left: 40, right: 40)),
                    ),
                    child: Text(
                      'Add Data',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Card(
                    color: Colors.grey.shade300,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/show');
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.only(left: 40, right: 40)),
                      ),
                      child: Text(
                        'Show Data',
                        style: TextStyle(color: Colors.black),
                      ),
                    ))
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Name:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextField(
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Email:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextField(
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Contact:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextField(
                        onChanged: (value) {
                          contact = value;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Address:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextField(
                        onChanged: (value) {
                          add = value;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Center(
                child: Card(
              color: Colors.orange.shade300,
              child: TextButton(
                onPressed: () {
                  sendServer(name, email, contact, add);
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.only(left: 40, right: 40)),
                ),
              ),
            )),
          )
        ],
      ),
    );
  }
}
