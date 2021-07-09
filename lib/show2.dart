import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Uri baseUrl = Uri.parse('https://dry-bayou-99944.herokuapp.com/profiles');

class API {
  static Future getUsers() {
    var url = baseUrl;
    return http.get(url);
  }
}

class User {
  int id;
  String name;
  String email;
  String contact;
  String address;

  User(int id, String name, String email, String contact, String address) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.contact = contact;
    this.address = address;
  }

  User.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        email = json['email'];
  //contact = json['contact'];
  //address = json['address'];

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'contact': contact,
      'address': address
    };
  }
}

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  var users = new List<User>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User List"),
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(users[index].address));
          },
        ));
  }
}
