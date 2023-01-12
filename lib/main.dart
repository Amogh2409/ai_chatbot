// ignore_for_file: use_key_in_widget_constructors

import 'package:ai_chatbot/chat_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'ChatGPT Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
        useMaterial3: true,
        
      ),
      home: ChatScreen(),
    );
  }
}

