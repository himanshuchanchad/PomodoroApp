import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screen/home_screen.dart';
import './screen/settings.dart';
import './screen/task_screeen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 1;
  int minuteVal;
  var screen = [TaskScreen(), HomeScreen(), Settings()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        accentColor: Colors.white,
        primaryTextTheme: TextTheme(
          headline6:
              TextStyle(backgroundColor: Colors.blue, color: Colors.white),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pomodoro App"),
        ),
        body: screen[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.content_paste),
              title: Text('Task'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
          selectedFontSize: 16.0,
          onTap: _onItemTapped,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.pink,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
