import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTask = Provider.of<Task>(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text(
              "Minutes",
              style: TextStyle(color: Colors.white,fontSize: 20),
            ),
          ),
          Container(
            child: Slider(
              value: currentTask.defaultMinuteWorkTimer,
              min: 1,
              max: 59,
              onChanged: (double value) {
                currentTask.setDefaultMinuteWorkTimer(value);
              },
              onChangeEnd: (double value) {
                currentTask.setDefaultMinuteWorkTimer(value);
              },
              divisions: 58,
              label: "${currentTask.defaultMinuteWorkTimer.toInt()}",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "Short Break",
              style: TextStyle(color: Colors.white,fontSize: 20),
            ),
          ),
          Container(
            child: Slider(
              value: currentTask.defaultMinuteBreakTimer,
              min: 1,
              max: 20,
              onChanged: (double value) {
                currentTask.setDefaultMinuteBreakTimer(value);
              },
              onChangeEnd: (double value) {
                currentTask.setDefaultMinuteBreakTimer(value);
              },
              divisions: 19,
              label: "${currentTask.defaultMinuteBreakTimer.toInt()}",
              activeColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
