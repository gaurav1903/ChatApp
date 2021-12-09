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
      appBar: AppBar(title: const Text('BEGIN')),
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
                    return Text("cool");
                  }
                  // log(snap.data.toString());
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: const Icon(Icons.add),
      ),
    );
  }
}
