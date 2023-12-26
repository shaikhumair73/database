import 'package:database/Model/model2.dart';
import 'package:database/database.dart';
import 'package:database/user_onboarding/login.dart';
import 'package:flutter/material.dart';

class SighnUp extends StatelessWidget {
  //const SighnUp({super.key});
  var emailControler = TextEditingController();
  var usernameControler = TextEditingController();
  var PasswordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sighn in"),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "create account",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 17,
          ),
          Text("gmail"),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: emailControler,
          ),
          SizedBox(
            height: 10,
          ),
          Text("username"),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: usernameControler,
          ),
          SizedBox(
            height: 10,
          ),
          Text("password"),
          SizedBox(
            height: 12,
          ),
          TextField(
            controller: PasswordControler,
          ),
          SizedBox(
            height: 15,
          ),
          TextButton(
              onPressed: () async {
                var appDB = AppDatabase.instance;
                var check = await appDB.creatAccount(UserModel(
                    gmail: emailControler.text.toString(),
                    user_name: usernameControler.text.toString(),
                    id: 0,
                    password: PasswordControler.text.toString()));
                var msg = "";
                if (check) {
                  msg = "user login succesfully";
                } else {
                  msg = "user cant login email is akready exist";
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(msg),
                ));

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              child: Text("sighn Up"))
        ],
      ),
    );
  }
}
