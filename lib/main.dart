import 'dart:async';
import 'dart:convert';

import 'package:beep_test/Level.dart';
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

class TimerHomePage extends StatefulWidget {
  TimerHomePage({Key key}) : super(key: key);

  @override
  _TimerHomePageState createState() => _TimerHomePageState();
}

Future<List<Level>> loadJson() async {
  final json = await rootBundle
      .loadString('assets/levels.json')
      .then((value) => jsonDecode(value));
  return json.map<Level>((json) => Level.fromJson(json)).toList();
}

class _TimerHomePageState extends State<TimerHomePage> {
  int _level = 1;
  num _time = 0;

  void _startTimer() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Level  $_level',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 38),
          ),
          Text(
            '$_time s',
            style: TextStyle(fontSize: 44),
          ),
          MaterialButton(onPressed: () => _startTimer(),
          child: Text('Start', style: TextStyle(fontSize: 25)),
            color: Color.fromRGBO(19, 168, 58, .6),
          )
        ],
      )),
    );
  }
}
