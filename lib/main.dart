import 'package:database/Model/modelclas.dart';
import 'package:database/database.dart';
import 'package:database/splash.dart';
import 'package:database/user_onboarding/login.dart';
import 'package:database/user_onboarding/sighnuppage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SighnUp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  // const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> ListData = [
    {
      "name": "setting",
      "icon": Icons.settings,
    },
    {
      "name": "profile",
      "icon": Icons.account_box,
    },
    {
      "name": "help",
      "icon": Icons.help,
    },
    {
      "name": "logout",
      "icon": Icons.logout,
    },
  ];

  var controler = TextEditingController();
  var controler1 = TextEditingController();

  @override
  late AppDatabase appDB;
  List<NoteModel> data = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    appDB = AppDatabase.instance;

    getAllNotes();
  }

  void getAllNotes() async {
    data = await appDB.fetchNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        title: Text(AppDatabase.Note_Table),
        backgroundColor: Colors.blue.shade300,
        actions: [
          Icon(Icons.search),
          PopupMenuButton(
              // onSelected: ,
              splashRadius: 100,
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              //tooltip: "setting",
              //  initialValue: ,
              //onSelected: () {},
              color: Colors.yellow,
              shadowColor: Colors.yellow,
              itemBuilder: (BuildContext context) {
                return ListData.map((e) {
                  return PopupMenuItem(
                    child: Row(
                      children: [
                        // e["icon"],
                        Icon(
                          e["icon"],
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          e["name"],
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }).toList();
              })
        ],
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var currData = data[index];
            return ListTile(
              leading: Text(
                "${index + 1}",
                style: TextStyle(color: Colors.black),
              ),
              title: Text(
                "${data[index].note_title}",
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text("${data[index].note_desc}"),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          addBottomSheet(
                              noteId: currData.note_id,
                              isEdit: true,
                              title: currData.note_title,
                              desc: currData.note_desc);
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        )),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Delete?"),
                                  content: Text("are you sure  want to delete"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          // appDB.deleteNote()
                                          appDB.deleteNote(currData.note_id);
                                          getAllNotes();
                                        },
                                        child: Text("yes")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("No")),
                                  ],
                                );
                              });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            addBottomSheet();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void addBottomSheet(
      {bool isEdit = false,
      int noteId = 0,
      String title = "",
      String desc = ""}) {
    if (isEdit == true) {
      controler.text = title;
      controler1.text = desc;
    } else {
      controler.text = "";
      controler1.text = "";
    }
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 600,
            padding: EdgeInsets.all(5),
            color: Colors.blue.shade300,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  isEdit == true ? "update title" : "add title",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controler,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  isEdit ? "update description" : "add description",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controler1,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          appDB = AppDatabase.instance;
                          //appDB.addNote("new Note", "implement db  in flutter app");
                          if (controler.text.isNotEmpty &&
                              controler1.text.isNotEmpty) {
                            if (isEdit) {
                              appDB.updateNote(NoteModel(
                                  user_id: 1,
                                  note_id: noteId,
                                  note_title: controler.text.toString(),
                                  note_desc: controler1.text.toString()));
                            } else {
                              appDB.addNote(NoteModel(
                                  user_id: 1,
                                  note_id: 0,
                                  note_title: controler.text.toString(),
                                  note_desc: controler1.text.toString()));
                            }

                            getAllNotes();
                          }
                        },
                        child: Text(isEdit == true ? "update" : "add")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("cancel")),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
