import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wedding_planner/model/check.dart';


class TodoScreen extends StatefulWidget {
  final String taskId;
  final String title;

  TodoScreen({this.taskId, this.title}) : super();

  @override
  State createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  List todoList = new List();
  List checkBoxList = new List();
  bool isLoading;
  
  @override
  void initState() {
    super.initState();
    isLoading = true;
   getTodosByTaskId('1vhPGZcsULOYef49lAmIVFT6ITk1');
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blueGrey,
        title: Text(widget.title),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               // Navigator.push(context,
//               //     MaterialPageRoute(builder: (context) => AddCheckScreen()));
//             },
//           )
//         ],
      ),
      body: Container(
        child: ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: todoList.length,
            itemBuilder: (BuildContext contex, int index) {
              var todo = todoList[index];
              return new Container(
                padding: EdgeInsets.only(left: 22.0, right: 22.0),
                child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
                    leading: Checkbox(
                      value: checkBoxList[index],
                        onChanged: (bool value) {
                          print(value);
                          if (value) {
                            updateChecklist(todo['id']);
                            setState(() {
                              checkBoxList[index] = value;
                            });
                          } else {
                            updateUnchecklist(todo['id']);
                            setState(() {
                              checkBoxList[index] = value;
                            });
                          }
                        }),
                     onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                todo['item'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("DELETE"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    deleteTodo(todo['id']);
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
                   
                    title: new Text(
                      todo['item'],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        decoration: todo['isComplete'] == true
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    )
                    ),
              );
            }),
      ),
    );
  }

  getTodosByTaskId(String id) async {
    setState(() {
      isLoading = true;
    });
    Response response;
    Dio dio = new Dio();
    try {
      dio
          .get(
              "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/todo?task_id=${widget.taskId}")
          .then((result) {
        setState(() {
          todoList = result.data['data'];
          checkBoxList = List.generate(result.data['data'].length, (i) {
            return result.data['data'][i]['is_complete'] ? true : false;
          });
        });
      }).catchError((err) {
        print(err);
      });
      Checks.fromJson(response.data['data']);
    } catch (e) {
      return print('error $e');
    }
  }
  updateChecklist(String id) async {
    Response response;
    Dio dio = new Dio();
    String url =
        "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/todo/$id/checklist";
    response = await dio.put(url);
    print('Response status: ${response.statusCode}');
  }
  updateUnchecklist(String id) async {
    Response response;
    Dio dio = new Dio();
    String url =
        "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/todo/$id/unchecklist";
    response = await dio.put(url);
    print('Response status: ${response.statusCode}');
  }

  deleteTodo(String id) async {
    Response response;
    Dio dio = new Dio();
    String url =
        "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/todo/$id";
    response = await dio.delete(url);
    print('Response status: ${response.statusCode}');
  }

}
