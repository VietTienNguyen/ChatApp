
import 'package:chatapp/screen/home_screen.dart';
import 'package:chatapp/screen/login.dart';
import 'package:chatapp/screen/register.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
//
class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/login':(context)=>Login(),
        '/register':(context)=>Register(),
      },
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}
