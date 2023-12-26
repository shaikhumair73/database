import 'package:database/database.dart';

class UserModel {
  String gmail;
  String user_name;
  int id;
  String password;
  UserModel(
      {required this.gmail,
      required this.user_name,
      required this.id,
      required this.password});
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        gmail: map[AppDatabase.User_gmail],
        user_name: map[AppDatabase.User_Name],
        id: map[AppDatabase.User_id],
        password: map[AppDatabase.User_Password]);
  }
  Map<String, dynamic> toMap() {
    return {
      AppDatabase.User_id: id,
      AppDatabase.User_gmail: gmail,
      AppDatabase.User_Name: user_name,
      AppDatabase.User_Password: password,
    };
  }
}
