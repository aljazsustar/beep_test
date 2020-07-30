
import 'components/TimerHomePageState.dart';
import 'package:flutter/cupertino.dart';
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
        ));
  }
}


