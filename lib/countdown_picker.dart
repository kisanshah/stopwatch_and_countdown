import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:stopwatch/countdown_loading.dart';

class CountDownPicker extends StatefulWidget {
  @override
  _CountDownPickerState createState() => _CountDownPickerState();
}

class _CountDownPickerState extends State<CountDownPicker> {
  int seconds = 0;
  int minutes = 1;
  int hour = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(Icons.more_horiz, color: Colors.white),
            )
          ],
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  "CountDown",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 190,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(80)),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Select the Time",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Theme.of(context).backgroundColor),
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Hour",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Theme.of(context).backgroundColor),
                              ),
                              Text(
                                "Minutes",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Theme.of(context).backgroundColor),
                              ),
                              Text(
                                "Seconds",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Theme.of(context).backgroundColor),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              NumberPicker.integer(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(
                                          width: 2.0, color: Colors.black54)),
                                  highlightSelectedValue: true,
                                  zeroPad: true,
                                  initialValue: hour,
                                  minValue: 0,
                                  maxValue: 99,
                                  onChanged: (newValue) =>
                                      setState(() => hour = newValue)),
                              NumberPicker.integer(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(
                                          width: 2.0, color: Colors.black54)),
                                  highlightSelectedValue: true,
                                  zeroPad: true,
                                  initialValue: minutes,
                                  minValue: 0,
                                  maxValue: 60,
                                  onChanged: (newValue) =>
                                      setState(() => minutes = newValue)),
                              NumberPicker.integer(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(
                                          width: 2.0, color: Colors.black54)),
                                  highlightSelectedValue: true,
                                  zeroPad: true,
                                  initialValue: seconds,
                                  minValue: 0,
                                  maxValue: 60,
                                  onChanged: (newValue) =>
                                      setState(() => seconds = newValue)),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 70,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountDownLoading(
                                          totalSeconds: totalSecond(),
                                          hours: hour,
                                          minutes: minutes,
                                          seconds: seconds,
                                        )));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Start Countdown",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.timer,
                                size: 30,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  int totalSecond() {
    int sum = hour * 3600 + minutes * 60 + seconds;
    return sum;
  }
}
