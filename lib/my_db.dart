import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class my_db{
  late Database _db;

  Future<void> initDatabase() async{ //開啟or新增SQL (第一次用會是新增)
    _db = await openDatabase(
      join(await getDatabasesPath(),'db1.db'), //傳入數據庫的路徑以及文件名
      onCreate: (db,vertion) {
        return db.execute("CREATE TABLE table01 (id INTEGER PRIMARY KEY, title TEXT, password TEXT)",); //創建SQL
      },
      version: 1,
    );
  }
  Future<void> clearDataBase() async{
    await _db.delete('table01'); //清除table01的所有資料
  }
  Future<void> insertToTable(String s1,String s2) async{ //新增資料至table01
    await _db.insert(
      'table01',
      {'title': s1,'password': s2},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<Map<String,dynamic>>> getTable() async{ //取得table01的所有資料
    return await _db.query('table01');
  }
}