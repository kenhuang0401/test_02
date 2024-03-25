import 'package:flutter/material.dart';
import 'package:test_02/Sing_up.dart';
import 'package:test_02/Page.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final btn = ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Page_01()),
      ),
      child: const Text("登入畫面"),
    );
    final widget = Container(
      child: Column(
        children: [btn],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 1),
      alignment: Alignment.center,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("標題"),
      ),
      body: widget,
    );
  }
}
