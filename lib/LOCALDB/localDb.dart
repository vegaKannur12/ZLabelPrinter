import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BarcodeDB {
  static final BarcodeDB instance = BarcodeDB._init();
  static Database? _database;
  BarcodeDB._init();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('mydb.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
          CREATE TABLE printertable (
            id INTEGER PRIMARY KEY,       
            dynamicCode TEXT          

          )
          ''');
    await db.execute('''
          CREATE TABLE itemtable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,       
            name TEXT,
            code TEXT,
            rate TEXT,
            unit TEXT,
            packing TEXT,
            exp_days INTEGER          

          )
          ''');
  }

  Future insertItemDetails(
      String nm, String cd, String rt, String uty, String pkng, int exp) async {
    final db = await database;
    var qr =
        'INSERT INTO itemtable(name,code,rate,unit,packing,exp_days) VALUES("$nm","$cd","$rt","$uty","$pkng",$exp)';
    var res = await db.rawInsert(qr);
    print(qr);
    print("Inserted ITEM data =====> $res");
    return res;
  }

  Future insertDetails(int i, String d_cod) async {
    final db = await database;
    var qr = 'INSERT INTO printertable(id,dynamicCode) VALUES($i,"$d_cod")';
    var res = await db.rawInsert(qr);
    print(qr);
    print("Inserted data =====> $res");
    return res;
  }

  Future selectDetails(int i) async {
    final db = await database;
    List<Map> result =
        await db.rawQuery('SELECT * FROM printertable WHERE id=?', [i]);
    result.forEach((row) => print("Selected data =====> $row"));
  }

  Future deleteAllDetails() async {
    final db = await database;
    var result = await db.rawDelete('DELETE from printertable');
    print("Deleted all data------------ $result");
    return result;
  }

  Future<List<Map>> allDetails() async {
    final db = await database;
    List<Map> result = await db.rawQuery('SELECT * FROM printertable');
    print("selected table------------$result");
    return result;
  }

  Future<List<Map<String, dynamic>>> allItemDetails() async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM itemtable');
    print("selected item details all------------$result");
    return result;
  }

  updateItemDetails(int id, String code, String rate, String unit,
      String packing, String exp) async {
    final db = await database;

    var result = await db.rawUpdate(
        'UPDATE itemtable set code="$code",rate="$rate",unit="$unit",packing="$packing",exp_days="$exp" where id=$id');
    // print(name);
    print("updated item------------$result");
    return result;
  }

  deleteData(int id) async {
    final db = await database;

    var result =
        await db.rawDelete('DELETE from printertable where id=?', [id]);
    print("Deleted------------ $result");
    return result;
  }

// Future<int> update(Map<String, dynamic> row) async {
//     int id = row[columnId];
//     return await _db.update(
//       table,
//       row,
//       where: '$columnId = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<List<TestDataTable>> getDetails() async {
//   final db = await database;
//   //query to get all students into a Map list
//   final List<Map<int, String>> studentMaps = await BarcodeDB.instance()
//   //converting the map list to student list
//   return List.generate(studentMaps.length, (i) {
//     //loop to traverse the list and return student object
//     return TestDataTable(
//       email: studentMaps[i]['email'],
//       name: studentMaps[i]['name'],
//       age: studentMaps[i]['age'],
//       rollNo: studentMaps[i]['rollNo'],
//     );
//   });
// }

  getListOfTables() async {
    Database db = await instance.database;
    var list = await db.query('sqlite_master', columns: ['type', 'name']);
    print(list);
    list.map((e) => print(e["name"])).toList();
    return list;
    // list.forEach((row) {
    //   print(row.values);
    // });
  }

  getTableData(String tablename) async {
    Database db = await instance.database;
    print(tablename);
    var list = await db.rawQuery('SELECT * FROM $tablename');
    print(list);
    return list;
    // list.map((e) => print(e["name"])).toList();
    // return list;
    // list.forEach((row) {
    //   print(row.values);
    // });
  }
}
