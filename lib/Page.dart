import 'package:flutter/material.dart';
import 'package:test_02/Log_in.dart';
import 'package:test_02/Sing_up.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Page_01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appbar = AppBar( //建立AppBar
      title: const Text("介面"),
      backgroundColor: Colors.blue,
      bottom: const TabBar( //設定TabBar
          tabs: [ //tab
            Tab(icon: Icon(Icons.login),text: '登入',), //設定Tab的圖標以及文字
            Tab(icon: Icon(Icons.person),text: '註冊',) //設定Tab的圖標以及文字
          ]
      ),
    );
    final tabbar = TabBarView( //Tab對應顯示的頁面
      children: [
        log_in(), //登入
        Sing_up(), //註冊
      ],
    );

    final apphome = Scaffold(appBar: appbar,body: tabbar,);
    return MaterialApp(
      home: DefaultTabController( //tabBar和TabBarView的控制器，用來統整所有資料並回傳
        length: 2, //tab數量
        child: apphome,
      )
    );
  }
}
