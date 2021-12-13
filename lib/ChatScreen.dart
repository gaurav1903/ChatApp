import 'package:chat_app/messages.dart';
import 'package:chat_app/new_message.dart';
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
      body: Container(
        child: Column(children: [
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ]),
      ),
    );
  }
}
