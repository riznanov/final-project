import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wedding_planner/api/task_api.dart';
import 'package:wedding_planner/model/category.dart';
import 'package:wedding_planner/pages/add_task_page.dart';
import 'package:wedding_planner/pages/todo_screen_page.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({Key key, this.userId}) : super(key: key);

  final String userId;

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  ApiTaskService apiTaskService;
  String url =
      "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/";
  String endPoint = "user_id=1vhPGZcsULOYef49lAmIVFT6ITk1";
  List taskList = new List();
  bool isLoading;
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    apiTaskService = ApiTaskService();
    super.initState();
    isLoading = true;
    getTasksById('1vhPGZcsULOYef49lAmIVFT6ITk1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.blueGrey,
          title: Text("To Do"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTaskScreen()));
              },
            )
          ],
        ),
        body: Container(
            child: new ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: taskList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                      child: ListTile(
                        title: new Text(
                          taskList[index]['title'],
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).canPop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext contex) => TodoScreen(
                                        taskId: taskList[index]['id'],
                                        title: taskList[index]['title'],
                                      )));
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(
                                    taskList[index]['title'],
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("UPDATE"),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: new TextField(
                                                  controller:
                                                      _textFieldController,
                                                  decoration: InputDecoration(
                                                      hintText: taskList[index]
                                                          ['title']),
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text("UPDATE"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      updateTask(taskList[index]['id'])
                                                        .then((isSuccess) {
                                                      if (isSuccess) {
                                                        setState(() {});
                                                        Scaffold.of(this.context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    "Update data success")));
                                                                    
                                                      } else {
                                                        Scaffold.of(this.context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    "Update data failed")));
                                                      }
                                                    });
                                                    getTasksById('1vhPGZcsULOYef49lAmIVFT6ITk1');
                                                    Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  FlatButton(
                                                    child: Text("CANCEL"),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("DELETE"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        deleteTask(taskList[index]['id'])
                                            .then((isSuccess) {
                                          if (isSuccess) {
                                            setState(() {});
                                            Scaffold.of(this.context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Delete data success")));
                                          } else {
                                            Scaffold.of(this.context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Delete data failed")));
                                          }
                                        });
                                        getTasksById(
                                            '1vhPGZcsULOYef49lAmIVFT6ITk1');
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        contentPadding: EdgeInsets.all(10),
                        
                        trailing: new Icon(Icons.arrow_right),
                      ),
                    ),
                  );
                })));
  }

  getTasksById(String id) async {
    setState(() {
      isLoading = true;
    });
    Response response;
    Dio dio = new Dio();

    try {
      dio.get('$url/tasks?user_id=$id').then((result) {
        setState(() {
          taskList = result.data['data'];
        });
      }).catchError((err) {
        print(err);
      });
      Categories.fromJson(response.data['data']);
    } catch (e) {
      return print('error WOOOOYYYYY $e');
    }
  }

  deleteTask(String id) async {
    Response response;
    Dio dio = new Dio();
    String url =
        "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/tasks/$id";
    response = await dio.delete(url);
    print('Response status: ${response.statusCode}');
  }

  updateTask(String id) async {
    Response response;
    Dio dio = new Dio();
    String url =
        "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/tasks/$id";
    response = await dio.put(url, data: {"title": _textFieldController.text});
    print('Response status: ${response.statusCode}');
  }
}
