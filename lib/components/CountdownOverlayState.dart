import 'dart:async';

import 'package:beep_test/components/TimerHomePageState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountdownOverlayState extends StatefulWidget {
  CountdownOverlayState({Key key}) : super(key: key);

  @override
  _CountdownOverlayState createState() => _CountdownOverlayState();
}

class _CountdownOverlayState extends State<CountdownOverlayState> {
  int _countdown = 5;
  Timer _countdownTimer;

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _startCountdown());
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else
        timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: Center(
      child: CircleAvatar(
        backgroundColor: Colors.green,
        radius: 90,
        child: Text(
          '$_countdown',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 70, color: Colors.white),
        ),
      ),
    ));
  }
}
