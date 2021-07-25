import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
          Padding(padding: EdgeInsets.only(bottom: 26)),
          Container(
            decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(
                    color: Colors.red, width: 2, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(26)),
            child: MaterialButton(
              minWidth: 200,
              onPressed: () {Navigator.pushNamed(context, '/login',arguments: {});},
              child: Text(
                'LOGIN',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 26)),
          Container(
            decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(
                    color: Colors.red, width: 2, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(26)),
            child: MaterialButton(
              minWidth: 200,
              onPressed: () {Navigator.pushNamed(context, '/register',arguments: {});},
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
    ));
  }
}
