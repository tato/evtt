import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vtt/cosmos.dart';

const double cardHeaderSize = 32;
const double resizeAreaSize = 24;
const double minCardWidth = 100;
const double minCardHeight = 100;

class XCard extends StatefulWidget {
  const XCard({
    Key? key,
    required this.setDragging,
    required this.child,
    this.width = 200,
    this.height = 150,
    this.title,
  }) : super(key: key);

  final void Function(XDraggable?) setDragging;
  final Widget child;
  final double width;
  final double height;
  final String? title;

  @override
  State<StatefulWidget> createState() => _XCardState();
}

class _XCardState extends State<XCard> implements XDraggable {
  double x = 0;
  double y = 0;
  late double w = widget.width;
  late double h = widget.height;
  bool resizing = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Listener(
        onPointerDown: (PointerDownEvent e) {
          if (w - e.localPosition.dx < resizeAreaSize && h - e.localPosition.dy < resizeAreaSize) {
            setState(() => resizing = true);
          } else {
            widget.setDragging(this);
          }
        },
        onPointerUp: (PointerUpEvent e) {
          setState(() => resizing = false);
        },
        onPointerMove: (PointerMoveEvent e) {
          if (resizing) {
            setState(() {
              w = max(minCardWidth, w + e.delta.dx);
              h = max(minCardHeight, h + e.delta.dy);
            });
          }
        },
        child: Stack(
          children: [
            Container(
              width: w,
              height: h,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green),
              ),
              child: widget.child,
            ),
            const Positioned(
              right: 0,
              bottom: 0,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeDownRight,
                child: SizedBox(
                  width: resizeAreaSize,
                  height: resizeAreaSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void drag(Offset offset) {
    setState(() {
      x += offset.dx;
      y += offset.dy;
    });
  }
}
