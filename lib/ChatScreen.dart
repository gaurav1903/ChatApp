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
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.done)
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  return Container(child: const Text('it works'));
                },
                itemCount: 5,
              );
            else
              return Text("Fucked");
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FirebaseFirestore.instance
            .collection('/chats/dJ2fGitAdiSSzupLpoRG/messages')
            .snapshots()
            .listen((data) {
          data.docs.forEach((element) {
            log(element.get('text'));
          });
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
