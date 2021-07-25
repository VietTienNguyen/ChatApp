import 'dart:ffi';
import 'package:chatapp/screen/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email;
  String password;

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Void> register() async {

    UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );


    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ScreenChat(
                  user: userCredential,
                )));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        color: Colors.blue, width: 2, style: BorderStyle.solid),
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
                        color: Colors.blue, width: 2, style: BorderStyle.solid),
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
                await register();
              },
              child: Text(
                'REGISTER',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
