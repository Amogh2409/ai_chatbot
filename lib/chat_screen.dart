import 'dart:async';

import 'package:ai_chatbot/chat_message.dart';
import 'package:ai_chatbot/three_dots.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  ChatGPT? chatGPT;

  StreamSubscription? _subscription;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    chatGPT = ChatGPT.instance;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _sendMessage() {
    ChatMessage message = ChatMessage(text: _controller.text, sender: "User");

    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    _controller.clear();

    final request = CompleteReq(
        prompt: message.text, model: kTranslateModelV3, max_tokens: 200);

    _subscription = chatGPT!
        .builder("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",
            orgId: "")
        .onCompleteStream(request: request)
        .listen((response) {
      Vx.log(response!.choices[0].text);
      ChatMessage botMessage =
          ChatMessage(text: response.choices[0].text, sender: "Bot");

      setState(() {
        _isTyping = false;
        _messages.insert(0, botMessage);
      });
    });
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) => _sendMessage(),
            decoration:
                const InputDecoration.collapsed(hintText: "Send a message"),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () => _sendMessage(),
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ChatBot Demo"),
          backgroundColor: Color.fromARGB(70, 158, 158, 158),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Flexible(
                  child: Container(
                   padding: const EdgeInsets.only(top: 18.0),
                    
                    child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: _messages.length,
                
                itemBuilder: (context, index) {
                    return _messages[index];
                },
              ),
                  )),
              if (_isTyping) ThreeDots(),
              Container(
                // alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.cardColor,
                ),
                child: _buildTextComposer(),
              )
            ],
          ),
        ));
  }
}
