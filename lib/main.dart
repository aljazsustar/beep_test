import 'dart:async';
import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beep_test/Level.dart';
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
  num _index = 0;
  num _level = 1;
  List<Level> _data;
  num _currentShuttle = 0;
  num _totalLevelTime = 0;
  num _shuttles;
  Timer _shuttleTimer;

  void _startTimer() {
    loadJson().then((value) {
      setState(() {
        _data = value;
      });
    });
    _shuttleTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_totalLevelTime <= 0 || _shuttles == 0) {
          AssetsAudioPlayer.newPlayer().open(Audio("assets/hoya.mp3"), autoStart: true);
          _totalLevelTime = _data[_index].totalLevelTime;
          _currentShuttle = _data[_index].timePerShuttle;
          _shuttles = _data[_index].shuttles;
          _level = _data[_index].level;
          _index++;
        }
        if (_currentShuttle > 0) _currentShuttle -= 0.1;
        if (_currentShuttle <= 0) {
          if (_shuttles > 0) {
            AssetsAudioPlayer.newPlayer().open(Audio("assets/hoya.mp3"), autoStart: true);
            _currentShuttle = _data[_index - 1].timePerShuttle;
            _shuttles--;
          }
        }
        _totalLevelTime -= 0.1;
      });
    });
  }

  void _stopTimer() {
    _shuttleTimer?.cancel();
  }

  void _reset() {
    _stopTimer();
    setState(() {
      _level = 1;
      _index = 0;
      _currentShuttle = 0;
      _totalLevelTime = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Current level distance: ${_data != null ?_data[_index == 0 ? 0 : _index - 1]?.levelDistance : 0}',
            style: TextStyle(color: Colors.black, fontSize: 26),
          ),
          Text(
            'Total distance: ${_data != null ? _data[_index == 0 ? 0 : _index - 1]?.totalDistance : 0}',
            style: TextStyle(color: Colors.black, fontSize: 26),
          ),
          Text(
            'Level  $_level',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 38),
          ),
          Text(
            'Total time:  ${num.parse(_totalLevelTime?.toStringAsFixed(1))} s',
            style: TextStyle(fontSize: 36),
          ),
          Text(
            'Current shuttle: ${num.parse(_currentShuttle?.toStringAsFixed(1))} s',
            style: TextStyle(fontSize: 34),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(

                onPressed: () => _startTimer(),
                child: Text('Start', style: TextStyle(fontSize: 25)),
                color: Color.fromRGBO(19, 168, 58, .6),
              ),
              MaterialButton(
                onPressed: () => _stopTimer(),
                child: Text('Pause', style: TextStyle(fontSize: 25)),
                color: Colors.yellow,
              ),
              MaterialButton(
                onPressed: () => _reset(),
                child: Text('Stop', style: TextStyle(fontSize: 25)),
                color: Colors.red,
              )
            ],
          )
        ],
      )),
    );
  }
}
