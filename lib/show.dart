import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Page1 extends StatefulWidget {
  //const Page1({ Key? key }) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  var final_data;
  String data;
  String name;
  String email;
  String address;
  String contact;

  void initState() {
    super.initState();
    getServer();
  }

  getServer() async {
    Uri url = Uri.parse('https://dry-bayou-99944.herokuapp.com/profiles');
    var r = await http.get(url);
    if (r.statusCode == 200) {
      data = r.body;
      setState(() {
        final_data = json.decode(data);
      });
    } else {
      print(r.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
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
        height: MediaQuery.of(context).size.height * 0.7,
        width: double.infinity,
        child: ListView.builder(
            itemCount: final_data == null ? 0 : final_data.length,
            itemBuilder: (BuildContext context, int index) {
              name = final_data[index]['name'].toString();
              email = final_data[index]['email'].toString();
              contact = final_data[index]['contact'].toString();
              address = final_data[index]['address'].toString();
              return Container(
                padding:
                    EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
                child: Card(
                  color: Colors.grey.shade300,
                  child: ListTile(
                    title: Text("\n$name\n\n$email\n\n$contact\n\n$address\n",
                        style: TextStyle(fontSize: 17)),
                  ),
                ),
              );
            }),
      )
    ]));
  }
}
