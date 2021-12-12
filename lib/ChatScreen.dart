import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatApp'),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 10),
                    Text('Logout')
                  ]),
                ),
                value: 'logout',
              )
            ],
            onChanged: (val) {
              //logout
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.more_vert),
            iconDisabledColor: Theme.of(context).primaryIconTheme.color,
            iconEnabledColor: Theme.of(context).primaryIconTheme.color,
          )
        ],
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            else
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('/chats/dJ2fGitAdiSSzupLpoRG/messages')
                      .snapshots(),
                  builder: (ctx, snap) {
                    if (snap.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    var x = snap.data as QuerySnapshot<Map<String, dynamic>>;
                    var y = x.docs;
                    return ListView.builder(
                      itemBuilder: (ctx, index) {
                        return Text(y[index]['text']);
                      },
                      itemCount: y.length,
                    );
                  }
                  // log(snap.data.toString());
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FirebaseFirestore.instance
            .collection('/chats/dJ2fGitAdiSSzupLpoRG/messages')
            .add({'text': 'added here'}),
        child: const Icon(Icons.add),
      ),
    );
  }
}
