import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          var z = snap.data as QuerySnapshot<Map<String, dynamic>>;
          return ListView.builder(
              reverse: true,
              itemCount: z.docs.length,
              itemBuilder: (ctx, index) {
                return MessageBubble(
                    z.docs[index]['text'].toString(),
                    z.docs[index]['userid'] ==
                        FirebaseAuth.instance.currentUser?.uid);
              });
        });
  }
}
