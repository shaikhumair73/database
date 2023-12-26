import 'package:database/database.dart';
import 'package:flutter/foundation.dart';

class NoteModel {
  int user_id;
  int note_id;
  String note_title;
  String note_desc;
  NoteModel(
      {required this.user_id,
      required this.note_id,
      required this.note_title,
      required this.note_desc});
  //from map --->Model
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      user_id: map[AppDatabase.User_id],
      note_id: map[AppDatabase.Note_id],
      note_title: map[AppDatabase.Note_title],
      note_desc: map[AppDatabase.Note_desc],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      AppDatabase.User_id: user_id,
      AppDatabase.Note_title: note_title,
      AppDatabase.Note_desc: note_desc
    };
  }
}
