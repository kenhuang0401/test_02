import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_02/Passwd_Page.dart';
import 'my_db.dart'; //記得引入它，要不然不能用

class log_in extends StatelessWidget{
  var myDB = my_db(); //引入另一個dart
  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(title: const Text("註冊帳戶介面"),backgroundColor: Colors.blue,);

    final mail = TextEditingController();
    final text01 = TextField(
      controller: mail,
      style: const TextStyle(fontSize: 16),
      decoration: const InputDecoration(
        hintText: "輸入帳號",
        hintStyle: const TextStyle(color: Colors.black38),
      ),
    );

    final passwd = TextEditingController();
    final text02 = TextField(
      controller: passwd,
      style: const TextStyle(fontSize: 16),
      decoration: const InputDecoration(
        hintText: "輸入密碼",
        hintStyle: const TextStyle(color: Colors.black38),
      ),
    );




    Future<bool> gothrough() async {
      await myDB.initDatabase();

      List<Map<String, dynamic>> td = await myDB.getTable();
      bool bl = true;

      for (var data in td) {
        if (mail.text == data['title'] && passwd.text == data['password']) {
          show_snackbar(context, "登入成功", true);
          mail.clear();
          passwd.clear();
          bl = false;
          break;
        }
      }

      if (bl) {
        show_snackbar(context, "沒有此帳密", false);
      }

      return bl;
    }


    final btn = ElevatedButton(
      child: const Text("登入"),
      onPressed: () async{
        bool bl = await gothrough();
        if(!bl) Navigator.push(context, MaterialPageRoute(builder: (context) => passwd_page()));
      },
    );

    final widget = Container(
      child: Column(
        children: <Widget>[
          Container(child: const Text("帳號",style: TextStyle(fontSize: 16),),
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(98, 20, 98, 0),),
          Container(child: text01,width: 200,),

          Container(child: const Text("密碼",style: TextStyle(fontSize: 16),),
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(98, 20, 98, 0),),
          Container(child: text02,width: 200,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: btn,margin: const EdgeInsets.fromLTRB(0, 20, 10, 20),),
            ],
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 1),
    );

    return widget;
  }

  void show_snackbar(BuildContext context,String s,bool bl){
    var color = null;
    if(bl) color = Colors.lightGreen;
    else color = Colors.red;

    final snackBar = SnackBar(
      content: Text(s),
      duration: const Duration(seconds: 2),
      backgroundColor: color,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}