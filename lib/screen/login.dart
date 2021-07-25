import 'dart:ffi';

import 'package:chatapp/screen/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;

  UserCredential userCredential;

  Future<Void> login() async {

      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ScreenChat(
                  user: userCredential,
                )));

      var currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        print(currentUser.email);
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  child: Image.asset("assets/images/logo.png"),
                ),
                Padding(padding: EdgeInsets.only(right: 12)),
                Container(
                  child: Text(
                    "ManUtd Chat",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 12)),
            TextField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Nhập eamil...",
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12))),
            ),
            Padding(padding: EdgeInsets.only(bottom: 12)),
            TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Nhập password...",
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12))),
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(
                      color: Colors.red, width: 2, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(26)),
              child: MaterialButton(
                minWidth: 200,
                onPressed: () async {
                  await login();
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
