import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'messages.dart';

class ScreenChat extends StatefulWidget {
  final UserCredential user;

  const ScreenChat({Key key, this.user}) : super(key: key);

  @override
  _ScreenChatState createState() => _ScreenChatState();
}

class _ScreenChatState extends State<ScreenChat> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> callback() async {
    if (controller.text.trim().isNotEmpty) {
      await _firestore.collection("messages").add({
        'text': controller.text.trim(),
        'from': widget.user.user.email,
        'date': DateTime.now().toIso8601String().toString(),
      });
      controller.clear();
    }
  }

  String from;
  String text;
  bool me;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat screen'),
          // leading: IconButton(icon: Icon(Icons.call),
          //
          // onPressed: (){
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppcall()));
          // },),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: 400,
                height: 600,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection("messages")
                      .orderBy('date')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView(
                      controller: scrollController,
                      children: snapshot.data.docs.map((document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        me = data['from'] == widget.user.user.email;
                        from = data['from'];
                        text = data['text'];
                        return Column(
                          crossAxisAlignment: me
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(from),
                            Material(
                              color: me ? Colors.yellowAccent : Colors.red,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                child: Text(text),
                              ),
                            )
                          ],
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "nhap tin nhan...",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 2,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(30))),
                          controller: controller,
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                      color: Colors.red,
                      child: MaterialButton(
                        onPressed: () {
                          callback();
                          Timer(
                              Duration(milliseconds: 300),
                              () => scrollController.jumpTo(
                                  scrollController.position.maxScrollExtent));
                        },
                        child: Text('send'),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
