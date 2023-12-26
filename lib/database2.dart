import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ShowData {
  ShowData._();
  static final ShowData data = ShowData._();
  Database? myDB;

  Future<Database> initDb() async {
    var dbDirectory = await getApplicationDocumentsDirectory();
    var dbpath = join(dbDirectory.path, "notes.db");
    return await openDatabase(dbpath, version: 1, onCreate: (db, version) {
      db.execute(
          "create table notes (noteId integer primary key autoincrement ,Title text, Desc text");
    });
  }

  Future<Database> getDb() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await initDb();
      return myDB!;
    }
  }

  void addData(mtitle, mdesc) async {
    var db = await getDb();
    db.insert("notes", {"Title": mtitle, "Desc": mdesc});
  }
}
