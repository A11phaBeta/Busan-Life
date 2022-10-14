import 'dart:async';

import 'package:busan_life/utils/touchbubble.dart';
import 'package:busan_life/utils/magnifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExamplePage extends StatefulWidget {
  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  static const double touchBubbleSize = 20;

  Offset position = Offset(50, 50);
  double currentBubbleSize = 20;
  bool magnifierVisible = false;

  @override
  void initState() {
    currentBubbleSize = touchBubbleSize;
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: Column(children: [
                  Stack(children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 150,
                        alignment: Alignment.center,
                        color: Colors.grey,
                        child: Magnifier2(
                            position: position,
                            visible: magnifierVisible,
                            child: Image.asset(
                              "assets/book-2.png",
                            ))),
                    TouchBubble(
                      position: position,
                      bubbleSize: currentBubbleSize,
                      onStartDragging: _startDragging,
                      onDrag: _drag,
                      onEndDragging: _endDragging,
                    ),
                  ]),
                  Container(
                      width: MediaQuery.of(context).size.width - 520,
                      height: 130,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 500,
                              height: 130,
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey),
                              child: Text("Video thumbnail visible box")),
                          Container(
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Row(
                                children: [
                                  OutlinedButton(
                                      onPressed: () {}, child: Text("Prev")),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  OutlinedButton(
                                      onPressed: () {}, child: Text("Next"))
                                ],
                              ))
                        ],
                      ))
                ]))));
  }

  void _startDragging(Offset newPosition) {
    setState(() {
      magnifierVisible = true;
      position = newPosition;
      currentBubbleSize = touchBubbleSize * 1.5;
    });
  }

  void _drag(Offset newPosition) {
    setState(() {
      position = newPosition;
    });
  }

  void _endDragging() {
    setState(() {
      currentBubbleSize = touchBubbleSize;
      magnifierVisible = false;
    });
  }
}
