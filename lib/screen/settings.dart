import 'package:PomodoroApp/providers/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/timer.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final currentTimer =
        Provider.of<CurrentTimer>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text("Minutes"),
          ),
          Container(
            child: Slider(
              value:currentTimer.getDefaultMinuteVal(),
              min: 0,
              max: 59,
              onChanged: (double value) {
                currentTimer.setDefaultVal(value);
              },
              onChangeEnd: (double value) {
                currentTimer.setDefaultVal(value);
              },
              divisions: 59,
              label: "${currentTimer.getDefaultMinuteVal().toInt()}",
            ),
          )
        ],
      ),
    );
  }
}
