import 'dart:async';
import 'dart:convert';

import 'components/TimerHomePageStatr.dart';
import 'file:///C:/Users/Aljaz/IdeaProjects/beep_test/lib/models/Level.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        ));
  }
}


