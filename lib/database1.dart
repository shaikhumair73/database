import 'package:database/database.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  Database? myDB;
  MyDatabase._();
  static final MyDatabase instatnce = MyDatabase._();
  Future<Database> initDB() async {
    var directory = await getApplicationDocumentsDirectory();
    var pathDB = join(directory.path, "notes.db");
    return openDatabase(pathDB, version: 1, onCreate: (db, version) {
      db.execute(
          "create table notes (noteid integer primary key autoincreament,title text, desc text)");
    });
  }

  Future<Database> getDB() async {
    return await initDB();
  }

  void addNote(String mTitle, String mDesc) async {
    var db = await getDB();
    db.insert("notes", {"title": mTitle, "desc": mDesc});
  }
}
