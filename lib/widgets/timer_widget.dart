import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/timer.dart';
class TimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTimer = Provider.of<CurrentTimer>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Text(
            currentTimer.timerString,
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * 0.1,
            ),
          ),
        ),
      ],
    );
  }
}
