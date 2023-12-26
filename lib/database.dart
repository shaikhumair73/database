import 'dart:ffi';

import 'package:database/Model/model2.dart';
import 'package:database/Model/modelclas.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final String Note_Table = "notes";
  static final String Note_id = "noteId";
  static final String Note_title = "title";
  static final String Note_desc = "desc";
  //login sighnup page
  static final String Login_Table = "login_table";
  static final String User_id = "user_id";
  static final String User_gmail = "user_gmail";
  static final String User_Name = "user_name";
  static final String User_Password = "user_password";
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();
  Database? myDB;
  Future<Database> initDB() async {
    var docDirectory = await getApplicationDocumentsDirectory();
    var dbPath = join(docDirectory.path, "notes.db");
    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      //create all yours tables

      db.execute(
          "create table $Login_Table ( $User_id integer primary key autoincrement,"
          " $User_gmail text, $User_Name text, $User_Password  text");
      db.execute(
          "create table $Note_Table ( $Note_id integer primary key autoincrement, $Note_title text, $Note_desc text, $User_id integer )");
    });
  }

  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await initDB();
      return myDB!;
    }
  }
  //insert data

  void addNote(NoteModel newNote) async {
    var db = await getDB();
    db.insert(Note_Table, newNote.toMap());
  }

  Future<List<NoteModel>> fetchNotes() async {
    var db = await getDB();
    List<NoteModel> arrNotes = [];
    var data = await db.query(Note_Table);
    for (Map<String, dynamic> eachNote in data) {
      var noteModel = NoteModel.fromMap(eachNote);
      arrNotes.add(noteModel);
    }

    return arrNotes;
  }

  void updateNote(NoteModel update) async {
    var db = await getDB();
    db.update(Note_Table, update.toMap(),
        where: "$Note_id=?", whereArgs: ["${update.note_id}"]);
  }

  void deleteNote(int id) async {
    var db = await getDB();
    db.delete(Note_Table, where: "$Note_id=$id");
  }

  Future<bool> creatAccount(UserModel newUser) async {
    var check = await cheackUserAlreeadyExist(newUser.gmail);
    if (!check) {
      var db = await getDB();
      db.insert(Login_Table, newUser.toMap());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> cheackUserAlreeadyExist(String gmail) async {
    var db = await getDB();
    var data = await db
        .query(Login_Table, where: "$User_gmail= ?", whereArgs: [gmail]);
    return data.isNotEmpty;
  }

  Future<bool> authenticateUser(String gmail, String password) async {
    var db = await getDB();
    var data = await db.query(Login_Table,
        where: "$User_gmail=? and $User_Password= ?",
        whereArgs: [gmail, password]);
    return data.isNotEmpty;
  }
}
