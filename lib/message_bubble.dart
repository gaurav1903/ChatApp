import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  String msg;
  bool isMe;
  Key k;
  MessageBubble(this.msg, this.isMe, this.k);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          !isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.grey.shade300 : Colors.purple,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
                  bottomRight:
                      isMe == false ? Radius.circular(12) : Radius.circular(0)),
            ),
            width: 140,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              msg,
              style: TextStyle(
                  color: isMe == true
                      ? Colors.black
                      : Theme.of(context).accentTextTheme.headline1?.color),
            ))
      ],
    );
  }
}
