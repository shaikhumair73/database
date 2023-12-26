import 'package:database/database.dart';
import 'package:database/database1.dart';
import 'package:database/main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  //const LoginPage({super.key});
  var emailControler = TextEditingController();
  var passControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("email id"),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: emailControler,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: passControler,
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () async{
                var email = emailControler.text.toString();
                var pass = passControler.text.toString();
                var db = AppDatabase.instance;
               if(await db.authenticateUser(email, pass)){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
               return MyHomePage();
             }));
               }
              },
              child: Text("login")),
        ],
      ),
    );
  }
}
