import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:vtt/cosmos.dart';

void main() {
  runApp(const AzaharApp());

  doWhenWindowReady(() {
    const initialSize = Size(600, 450);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "pablo's experimental vtt";
    appWindow.show();
    appWindow.maximize();
  });
}

class AzaharApp extends StatelessWidget {
  const AzaharApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: "Cousine",
      ),
      home: const Scaffold(body: Cosmos()),
    );
  }
}
