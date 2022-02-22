import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task4/GetMethodScreen.dart';
import 'dart:convert';
import 'dart:async';
import 'package:task4/PostMethodScreen.dart';
import 'API Model/UserModel.dart';
import 'package:task4/GetMethodScreen.dart';
//https://jsonplaceholder.typicode.com/posts

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "API Calls",
      home: Body(),
    );
  }
}
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _selectedIndex = 0;
  ItemTaped(index){
    setState(() {
      _selectedIndex = index;
    });
  }
  static const List<Widget> _pages = <Widget>[
    GetMethodScreen(),
    PostMethodScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API Requests'),),
      body: Center(
        // child: PutMethodScreen(),
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.get_app),label: "get"),
          BottomNavigationBarItem(icon: Icon(Icons.post_add),label: "post"),
        ],
        currentIndex: _selectedIndex,
        onTap: ItemTaped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
