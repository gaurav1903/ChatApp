import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredmsg = "";
  final controller = new TextEditingController();
  void sendMsg() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredmsg,
      'time': Timestamp.now(),
      'userid': FirebaseAuth.instance.currentUser?.uid
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
            child: TextField(
                controller: controller,
                onChanged: (val) {
                  setState(() {
                    _enteredmsg = val;
                  });
                },
                decoration: InputDecoration(labelText: 'SEND MESSAGE'))),
        IconButton(
          color: Theme.of(context).primaryColor,
          icon: Icon(Icons.send),
          onPressed: _enteredmsg.trim().isEmpty
              ? null
              : () {
                  sendMsg();
                  _enteredmsg = '';
                },
        )
      ]),
    );
  }
}
