import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  List<String> items = [];
  int lapCount = 0;
  ScrollController scrollController = new ScrollController();
  Stopwatch watch = Stopwatch();
  Timer timer;
  String elapsedTime = '';
  String second = '00';
  String minute = '00';
  String millisecond = '00';
  Icon pause = Icon(Icons.pause);
  Icon flag = Icon(Icons.flag);
  Icon play = Icon(Icons.play_arrow);
  Icon reset = Icon(Icons.refresh);

  bool isStarted = false;
  bool isReset = false;
  double height = 0.0;
  double width = 0.0;

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(milliseconds: 1000),
        () =>
            scrollController.jumpTo(scrollController.position.maxScrollExtent));

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          )
        ],
        leading: Icon(Icons.arrow_back_ios, color: Colors.white),
        backgroundColor: Colors.transparent,
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
                "Stop Watch",
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 70),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(minute + " :",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50,
                                        color:
                                            Theme.of(context).backgroundColor)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(second + " :",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50,
                                        color:
                                            Theme.of(context).backgroundColor)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(millisecond,
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50,
                                        color:
                                            Theme.of(context).backgroundColor)),
                              ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: AnimatedContainer(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                duration: Duration(seconds: 1),
                                child: IconButton(
                                  icon: isStarted ? pause : play,
                                  onPressed: () {
                                    isStarted ? stopWatch() : startWatch();
                                  },
                                  iconSize: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: AnimatedContainer(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                duration: Duration(seconds: 1),
                                child: IconButton(
                                  icon: isStarted ? flag : reset,
                                  onPressed: () {
                                    isStarted
                                        ? addLap(elapsedTime)
                                        : resetWatch();
                                  },
                                  iconSize: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Expanded(
                      child: new ListView.builder(
                          itemCount: items.length,
                          controller: scrollController,
                          itemBuilder: (BuildContext context, int index) {
                            return createList(
                                (index + 1).toString(), items[index]);
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  startWatch() {
    watch.start();
    isStarted = true;
    timer = Timer.periodic(Duration(milliseconds: 50), updateTime);
  }

  stopWatch() {
    isStarted = false;
    watch.stop();
    setTime();
  }

  resetWatch() {
    watch.reset();
    items.clear();
    setTime();
  }

  setTime() {
    var currentTime = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliseconds(currentTime);
    });
  }

  transformMilliseconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minuteStr = (minutes % 60).toString().padLeft(2, "0");
    String secondsStr = (seconds % 60).toString().padLeft(2, "0");
    String hundredStr = (hundreds % 100).toString().padLeft(2, "0");

    minute = minuteStr.toString();
    second = secondsStr.toString();
    millisecond = hundredStr.toString();
    return "$minuteStr: $secondsStr: $hundredStr";
  }

  void updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transformMilliseconds(watch.elapsedMilliseconds);
      });
    }
  }

  void addLap(String time) {
    items.add("$minute : $second : $millisecond");
  }

  Widget createList(String count, String lapTime) {
    return Container(
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              count.padLeft(2, "0"),
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).backgroundColor),
            ),
            Container(
              width: 180,
              child: Text(
                lapTime.padLeft(2, "0"),
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).backgroundColor),
              ),
            )
          ],
        ));
  }
}
