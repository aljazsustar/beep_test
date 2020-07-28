import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beep Test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Beep Test'),
          backgroundColor: Colors.black45,
          centerTitle: true,
        ),
        body: TimerHomePage(),
      )
    );
  }
}

class TimerHomePage extends StatefulWidget {
  TimerHomePage({Key key}): super(key: key);

  @override
  _TimerHomePageState createState() => _TimerHomePageState();
}

class _TimerHomePageState extends State<TimerHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Space for timer and data"),),
    );
  }
}