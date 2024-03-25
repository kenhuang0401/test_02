import 'package:flutter/material.dart';
import 'package:test_02/Sing_up.dart';
import 'package:test_02/Page.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class passwd_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widget = Container(
      child: Column(
        children: [const Text(":)")],
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
