import 'dart:async';

import 'package:beep_test/components/TimerHomePageState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/* TODO should probably be stateful, this should display the timer by itself,
without calls from other components */
class CountdownWidget extends StatelessWidget {

  CountdownWidget({Key key, this.second }) : super(key: key);

  final num second;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: 90,
            child: Text(
              '$second',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 70,
                  color: Colors.white),
            ),
          ),
        ));
  }
}
