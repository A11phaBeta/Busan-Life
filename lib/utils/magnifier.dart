import 'dart:ui';

import 'package:flutter/material.dart';

class Magnifier2 extends StatefulWidget {
  const Magnifier2(
      {required this.child,
      required this.position,
      this.visible = true,
      this.scale = 1.5,
      this.size = const Size(320, 320)})
      : assert(child != null);

  final Widget child;
  final Offset position;
  final bool visible;
  final double scale;
  final Size size;

  @override
  _MagnifierState createState() => _MagnifierState();
}

class _MagnifierState extends State<Magnifier2> {
  late Size _magnifierSize;
  late double _scale;
  late Matrix4 _matrix;

  @override
  void initState() {
    _magnifierSize = widget.size;
    _scale = widget.scale;
    _calculateMatrix();

    super.initState();
  }

  @override
  void didUpdateWidget(Magnifier2 oldWidget) {
    super.didUpdateWidget(oldWidget);

    _calculateMatrix();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.visible && widget.position != null) _getMagnifier(context)
      ],
    );
  }

  void _calculateMatrix() {
    if (widget.position == null) {
      return;
    }

    setState(() {
      double newX = widget.position.dx - (_magnifierSize.width / 2 / _scale);
      double newY = widget.position.dy - (_magnifierSize.height / 2 / _scale);

      final Matrix4 updatedMatrix = Matrix4.identity()
        ..scale(_scale, _scale)
        ..translate(-newX, -newY);

      _matrix = updatedMatrix;
    });
  }

  Widget _getMagnifier(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.matrix(_matrix.storage),
            child: Container(
              width: _magnifierSize.width,
              height: _magnifierSize.height,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2)),
            ),
          ),
        ));
  }
}
