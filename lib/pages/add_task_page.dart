import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wedding_planner/pages/task_screen_page.dart';
// import 'package:wedding_planner/model/category.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String url =
      "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/tasks/";

  bool isLoading;
  String newTask;
  String userId;
  TextEditingController taskController;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void dispose() {
    super.dispose();
    taskController.dispose();
  }

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   newTask = "";
    //  });
    taskController = TextEditingController();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tambah Taks',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        brightness: Brightness.light,
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Apa yang Anda rencanakan?',
              style: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0),
            ),
            Container(
              height: 16.0,
            ),
            TextFormField(
              controller: taskController,
              autofocus: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '...',
                  hintStyle: TextStyle(
                    color: Colors.black26,
                  )),
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 36.0),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(builder: (BuildContext contex) {
        return FloatingActionButton.extended(
          icon: Icon(Icons.add),
          backgroundColor: Color(0xFF009688),
          label: Text("Tambah Task"),
          onPressed: () {
            if (taskController.text.isEmpty) {
              final snackBar = SnackBar(
                content: Text('Anda belum melakukan input'),
              );
              Scaffold.of(context).showSnackBar(snackBar);
              _scaffoldKey.currentState.showSnackBar(snackBar);
            } else {
              postTask();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => TaskScreen()));
            }
          },
        );
      }),
    );
  }

  postTask() async {
    Response response;
    Dio dio = new Dio();

    response = await dio.post(url, data: {
      "user_id": "1vhPGZcsULOYef49lAmIVFT6ITk1",
      "title": taskController.text
    });
    print('Response status: ${response.statusCode}');
  }
}
