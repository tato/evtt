import 'package:flutter/material.dart';
import 'package:vtt/cosmos.dart';

const double cardHeaderSize = 32;

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

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.green),
        ),
        child: Stack(
          children: [
            // Listener(
            //   onPointerDown: (PointerDownEvent e) => widget.setDragging(this),
            //   child: Container(
            //     height: 32,
            //     color: Colors.greenAccent,
            //     child: widget.title != null
            //         ? Center(
            //             child: Text(
            //               widget.title!,
            //               style: Theme.of(context).textTheme.titleMedium,
            //             ),
            //           )
            //         : null,
            //   ),
            // ),
            Positioned(top: cardHeaderSize, child: widget.child),
            Listener(
              onPointerDown: (PointerDownEvent e) => widget.setDragging(this),
              child: const Icon(
                Icons.drag_indicator,
                color: Colors.green,
                size: cardHeaderSize,
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
