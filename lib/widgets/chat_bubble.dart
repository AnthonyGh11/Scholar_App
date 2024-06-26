import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';

// ignore: must_be_immutable
class ChatBubble extends StatelessWidget {
  ChatBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        alignment: Alignment.centerLeft,
        padding:
            const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: kPrimaryColor,
        ),
        child: Text(
          message.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatBubbleForFriend extends StatelessWidget {
  ChatBubbleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);

  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        alignment: Alignment.centerRight,
        padding:
            const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Color(0xff006D84),
        ),
        child: Text(
          message.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
