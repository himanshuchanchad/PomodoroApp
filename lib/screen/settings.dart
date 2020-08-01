import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  // int minuteVal;
  @override
  _SettingsState createState() => _SettingsState();

  // Settings(this.minuteVal);
}

class _SettingsState extends State<Settings> {
  int minuteValue = 45;
  @override
  Widget build(BuildContext context) {
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
              value: minuteValue.toDouble(),
              min: 0,
              max: 59,
              onChanged: (double value) {
                setState(() {
                  this.minuteValue = value.toInt();
                });
              },
              onChangeEnd: (value) {
                print(value);
              },
              divisions: 59,
              label: "$minuteValue",
            ),
          )
        ],
      ),
    );
  }
}
