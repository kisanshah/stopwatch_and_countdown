import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/countdown_picker.dart';
import 'package:stopwatch/stop_watch.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        primaryColor: Colors.white30,
        accentColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      theme: ThemeData(
          accentColor: Color(0xFF7A9BEE),
          backgroundColor: Colors.black54,
          primaryColor: Colors.white,
          brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final tabs = [StopWatch(), CountDownPicker()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            title: Text("StopWatch"),
            backgroundColor: Theme.of(context).accentColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            title: Text("Count Down"),
            backgroundColor: Theme.of(context).accentColor,
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
