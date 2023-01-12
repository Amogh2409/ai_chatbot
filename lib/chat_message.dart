import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({Key? key, required this.text, required this.sender}) : super(key: key);
  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sender)
            .text
            .subtitle1(context)
            .make()
            .box
            .color(sender == "User" ? Color.fromARGB(255, 194, 251, 253) : Vx.green200)
            .p12
            .roundedFull
            .alignCenter
            .make(),
        Expanded(
          child: text.trim().text.bodyText1(context).make().px4().py12()
        ),
      ],
    ).py8();
  }
}
