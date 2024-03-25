import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'my_db.dart'; //記得引入它，要不然不能用

class Sing_up extends StatelessWidget{
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




    Future<void> gothrough() async {
      await myDB.initDatabase();

      List<Map<String, dynamic>> td = await myDB.getTable();
      bool bl = true;

      for (var data in td) {
        if (mail.text == data['title'] && passwd.text == data['password']) {
          show_snackbar(context, "帳密已被註冊", false);
          bl = false;
          break;
        }
      }

      if (bl) {
        //await myDB.initDatabase();
        await myDB.insertToTable(mail.text, passwd.text);
        show_snackbar(context, "註冊成功", true);
        mail.clear();
        passwd.clear();
      }
    }


    final btn = ElevatedButton(
      child: const Text("註冊"),
      onPressed: () async{
        await gothrough();
      },
    );

    final btn02 = ElevatedButton(
      child: const Text("帳戶"),
      onPressed: () {
        _showdialog(context); //開啟AlertDialog
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
              btn02,
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

  _showdialog(BuildContext context) async{
    var builder = AlertDialog(
        content: Container(
          width: 200, //畫面的寬
          height: 300, //畫面的高
          child: SQL(), //SQL的class
        )
    );

    showDialog(context: context, builder: (context) => builder);
  }
}

class SQL extends StatefulWidget {
  @override
  _SQLState createState() => _SQLState();
}

class _SQLState extends State<SQL> {
  var myDB = my_db(); //引入SQL

  @override
  void initState() { //在生命週期中，會在build之前被調用，通常是用來初始化狀態
    super.initState();
    initDatabaseAndInsertData(); //呼叫異步處裡，更新並顯示SQL的內容
  }
  Future<void> initDatabaseAndInsertData() async {
    await myDB.initDatabase(); // 初始化數據庫
    setState(() {}); // 更新內容
  }

  @override
  Widget build(BuildContext context) {
    final btn_dl = ElevatedButton(
      child: const Text("刪除"),
      onPressed: () async{
        await myDB.clearDataBase(); //刪除內容
        setState(() {});
      },
    );

    final f = FutureBuilder<List<Map<String,dynamic>>>( //FutureBuilder 根據異步處理的結果來建構UI
      future: myDB.getTable(), //要等待的異步操作
      builder: (context,snapshot) {
        //context 當前Widget
        //snapshot 異步處理當前的狀態與數據
        if(snapshot.connectionState == ConnectionState.waiting){ //加載中的狀態
          return CircularProgressIndicator(); //圓形進度圖
        }
        else { //數據加載完成
          final table = snapshot.data ?? []; //將snapshot的值傳給table
          return Column(
              children: table.map((db){ //歷遍table，也就是SQL內的資料
                return ListTile( //轉成ListTile
                    title: Text(db['title']), //標題
                    subtitle: Text("密碼: " + db['password']), //內文
                    leading: Icon(Icons.person,) //圖標
                );
              }).toList()); //轉成ListView
        }
      },
    );

    return Container(
      child: Column(
        children: [
          Container(child: const Text("已註冊帳戶:",style:TextStyle(fontSize: 16),),alignment: Alignment.topLeft,), //靠左顯示
          Expanded( //填滿空間
            child: SingleChildScrollView(child: f,), //滾動視圖
          ),
          Container(child: btn_dl,alignment: Alignment.topRight,), //靠右顯示
        ],
      ),
    );
  }
}