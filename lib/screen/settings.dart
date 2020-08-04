import 'package:PomodoroApp/providers/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/timer.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTimer = Provider.of<CurrentTimer>(context);
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
              value: currentTimer.getDefaultMinuteVal(),
              min: 0,
              max: 59,
              onChanged: (double value) {
                currentTimer.changeDefaultVal(value);
              },
              onChangeEnd: (double value) {
                currentTimer.setDefaultMinuteVal(value);
              },
              divisions: 59,
              label: "${currentTimer.getDefaultMinuteVal().toInt()}",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text("Short Break"),
          ),
          Container(
            child: Slider(
              value: currentTimer.getDefaultShortBreak().toDouble(),
              min: 0,
              max: 20,
              onChanged: (double value) {
                currentTimer.changeDefaultShortBreak(value.toInt());
              },
              onChangeEnd: (double value) {
                currentTimer.setDefaultShortBreak(value.toInt());
              },
              divisions: 20,
              label: "${currentTimer.getDefaultShortBreak()}",
              activeColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
