import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:beep_test/components/CountdownWidget.dart';
import 'package:beep_test/models/Level.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class TimerHomePage extends StatefulWidget {
  TimerHomePage({Key key}) : super(key: key);

  @override
  _TimerHomePageState createState() => _TimerHomePageState();
}

class _TimerHomePageState extends State<TimerHomePage> {
  num _index = 0;
  num _level = 1;
  List<Level> _data;
  num _currentShuttle = 0;
  num _totalLevelTime = 0;
  num _shuttles;
  Timer _shuttleTimer;
  Timer _countdownTimer;
  bool _isStarted = false;
  bool _isPaused = false;
  CountdownWidget _countdownWidget;
  num _countdown = 5;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => loadJson().then((value) => {_data = value}));
  }

  void startCountdown() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdownWidget = CountdownWidget(second: _countdown);
          _countdown--;
        } else {
          _countdown = 5;
          _countdownWidget = null;
          timer.cancel();
        }
      });
    });
  }

  void _startTimer() async {
    startCountdown();
    // TODO this is dumb, we need to find a better solution
    // startCountdown() should finish first, execution should be halted for
    // the duration of countdown
    // now it is halted manually using the line below
    await new Future.delayed(Duration(milliseconds: 5300));
    _isPaused = false;
    _isStarted = true;
    _shuttleTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_totalLevelTime <= 0 || _shuttles == 0) {
          AssetsAudioPlayer.newPlayer()
              .open(Audio("assets/hoya2.mp3"), autoStart: true);
          updateData(_index);
          _index++;
        }
        if (_currentShuttle > 0) _currentShuttle -= 0.1;
        if (_currentShuttle <= 0) {
          if (_shuttles > 0) {
            AssetsAudioPlayer.newPlayer()
                .open(Audio("assets/hoya2.mp3"), autoStart: true);
            _currentShuttle = _data[_index - 1].timePerShuttle;
            _shuttles--;
          }
        }
        _totalLevelTime -= 0.1;
      });
    });
  }

  void updateData(num index) {
    Level data = _data[index];
    _totalLevelTime = data.totalLevelTime;
    _currentShuttle = data.timePerShuttle;
    _shuttles = data.shuttles;
    _level = data.level;
    _index = index;
  }

  Future<List<Level>> loadJson() async {
    final json = await rootBundle
        .loadString('assets/levels.json')
        .then((value) => jsonDecode(value));
    return json.map<Level>((json) => Level.fromJson(json)).toList();
  }

  void _stopTimer() {
    setState(() {
      _isPaused = true;
    });
    _shuttleTimer?.cancel();
  }

  void _reset() {
    _isPaused = false;
    _isStarted = false;
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
    // TODO there also has to be a better solution for this
    return _countdownWidget == null ? Scaffold(
      backgroundColor: Colors.black,
      body:
      Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Current level distance: ${_data != null ? _data[_index == 0 ? 0 : _index - 1]?.levelDistance : 0}',
            style: TextStyle(color: Colors.white, fontSize: 26),
          ),
          Text(
            'Total distance: ${_data != null ? _data[_index == 0 ? 0 : _index - 1]?.totalDistance : 0}',
            style: TextStyle(color: Colors.white, fontSize: 26),
          ),
          DropdownButton<num>(
            value: _level,
            icon: Icon(Icons.arrow_drop_down),
            style: TextStyle(fontSize: 30, color: Colors.white),
            dropdownColor: Colors.black,
            onChanged: (num newLevel) {
              setState(() {
                updateData(newLevel - 1);
              });
            },
            items: _data?.map((Level val) {
              return DropdownMenuItem<num>(
                value: val.level,
                child: Text('Level ${val.level.toString()}'),
              );
            })?.toList(),
          ),
          Text(
            'Total time:  ${num.parse(_totalLevelTime?.toStringAsFixed(1))} s',
            style: TextStyle(fontSize: 36, color: Colors.white),
          ),
          Text(
            'Current shuttle: ${num.parse(_currentShuttle?.toStringAsFixed(1))} s',
            style: TextStyle(fontSize: 34, color: Colors.white),
          ),
          // CountdownOverlayState(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!_isStarted || _isPaused)
              MaterialButton(
                onPressed: () => _startTimer(),
                child: Text('Start',
                    style: TextStyle(fontSize: 25, color: Colors.white)),
                color: Color.fromRGBO(19, 168, 58, .6),
              ),
              if (_isStarted && !_isPaused)
                MaterialButton(
                  onPressed: () => _stopTimer(),
                  child: Text('Pause',
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  color: Color.fromRGBO(255, 213, 0, 1),
                ),
              if (_isStarted)
                MaterialButton(
                  onPressed: () => _reset(),
                  child: Text('Stop',
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  color: Colors.red,
                )
            ],
          )
        ],
      )),
    ) : _countdownWidget.build(context);
  }
}
