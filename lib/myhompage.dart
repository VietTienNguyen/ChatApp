import 'package:chatapp/screen/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selecter=0;
  List<Widget> items=[
    ScreenChat(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:items[_selecter],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
        currentIndex: _selecter,
        onTap: (value){
          setState(() {
            _selecter=value;
          });
        },
      ),
    );
  }
}
