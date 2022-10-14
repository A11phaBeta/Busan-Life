import 'package:flutter/material.dart';

class TouchBubble extends StatelessWidget {
  final Offset position;
  final double bubbleSize;
  final Function onStartDragging;
  final Function onDrag;
  final Function onEndDragging;

  TouchBubble({
    required this.position,
    required this.onStartDragging,
    required this.onDrag,
    required this.onEndDragging,
    required this.bubbleSize,
  })  : assert(onStartDragging != null),
        assert(onDrag != null),
        assert(onEndDragging != null),
        assert(bubbleSize != null && bubbleSize > 0);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: position == null ? 0 : position.dy - bubbleSize / 2,
        left: position == null ? 0 : position.dx - bubbleSize / 2,
        child: GestureDetector(
            onPanStart: (details) => onStartDragging(details.globalPosition),
            onPanUpdate: (details) => onDrag(details.globalPosition),
            onPanEnd: (_) => onEndDragging(),
            child: Container(
              width: bubbleSize,
              height: bubbleSize,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).accentColor.withOpacity(0.8)),
            )));
  }
}
