import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/custom_timer_painter.dart';

class CountDownLoading extends StatefulWidget {
  final int totalSeconds;
  final int seconds;
  final int minutes;
  final int hours;

  const CountDownLoading(
      {Key key, this.totalSeconds, this.seconds, this.minutes, this.hours});

  @override
  _CountDownLoadingState createState() => _CountDownLoadingState();
}

class _CountDownLoadingState extends State<CountDownLoading>
    with TickerProviderStateMixin {
  AnimationController controller;
  bool isStarted = false;
  Icon pause = Icon(Icons.pause);
  Icon play = Icon(Icons.play_arrow);

  @override
  Widget build(BuildContext context) {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.totalSeconds),
    );

    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Icon(Icons.more_horiz,color: Colors.white,),
                onPressed: () {},
              ),
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
                  "CountDown",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
                  color: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        return Column(
                          children: <Widget>[
                            Container(
                              height: 250,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(150))),
                              child: CustomPaint(
                                painter: CustomTimerPainter(
                                  animation: controller,
                                  backgroundColor: Colors.white,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.5),
                                ),
                                child: Center(
                                    child: Text(
                                  timerString,
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white),
                                )),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            AnimatedBuilder(
                                animation: controller,
                                builder: (context, child) {
                                  return Container(
                                    width: 200,
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .accentColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          child: IconButton(
                                            icon: play,
                                            onPressed: () {
                                              controller.reverse(
                                                  from: controller.value == 0.0
                                                      ? 1.0
                                                      : controller.value);
                                            },
                                            iconSize: 35,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .accentColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          child: IconButton(
                                            icon: pause,
                                            onPressed: () {
                                              controller.stop();
                                            },
                                            iconSize: 35,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        );
                      }),
                ),
              )
            ],
          ),
        ));
  }

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${(duration.inHours).toString().padLeft(2, "0")}:${(duration.inMinutes % 60).toString().padLeft(2, "0")}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}
