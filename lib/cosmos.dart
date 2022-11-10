import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:vtt/card.dart';

const snoop =
    "http://t2.gstatic.com/licensed-image?q=tbn:ANd9GcRYMb4Y_DrHRITbrptKy2ovNXkKyvqrOuRyJPDYfqongQ1n8_0TxC6lUNzOYiIbZFvYSfwhKqx6G1sV89g";

class Cosmos extends StatefulWidget {
  const Cosmos({Key? key}) : super(key: key);

  @override
  State<Cosmos> createState() => _CosmosState();
}

class _CosmosState extends State<Cosmos> {
  XDraggable? _dragging;

  void _setDragging(XDraggable? draggable) {
    setState(() {
      _dragging = draggable;
    });
  }

  void _handlePointerMove(PointerMoveEvent event) {
    _dragging?.drag(event.delta);
  }

  void _handlePointerUp(PointerUpEvent event) {
    setState(() {
      _dragging = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WindowTitleBarBox(
          child: Row(
            children: [
              Expanded(
                child: MoveWindow(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("  🫧 pablo's experimental vtt"),
                  ),
                ),
              ),
              MinimizeWindowButton(),
              MaximizeWindowButton(),
              CloseWindowButton(),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: const Color(0xFFF0F0F0),
            child: Listener(
              onPointerMove: _handlePointerMove,
              onPointerUp: _handlePointerUp,
              child: Stack(
                children: [
                  XCard(
                    setDragging: _setDragging,
                    child: Image.network(snoop, scale: 10),
                  ),
                  XCard(
                    title: "RNG",
                    setDragging: _setDragging,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder(), hintText: "not me"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

abstract class XDraggable {
  void drag(Offset offset);
}
