import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wedding_planner/pages/add_check_page.dart';

class CheckScreen extends StatefulWidget {
  final String categoriId;

  CheckScreen({this.categoriId}) : super();

  @override
  State createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  List checkList = new List();
  List checkBoxList = new List();
  bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getChecksByCategoriId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blueGrey,
        title: Text("Detail Checklist"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddCheckScreen()));
            },
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: checkList.length,
            itemBuilder: (BuildContext contex, int index) {
              print(checkBoxList);
              var check = checkList[index];
              return new Container(
                padding: EdgeInsets.only(left: 22.0, right: 22.0),
                child: ListTile(
                    // onTap: () {
                    //   setState(() {
                    //     checkBoxList[index] = check['isComplete'];
                    //   });
                    // },
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
                    leading: Checkbox(
                        value: checkBoxList[index],
                        onChanged: (bool value) {
                          print(value);
                          if (value) {
                            updateeChecklist(check['id']);
                            setState(() {
                              checkBoxList[index] = value;
                            });
                          } else {
                            updateeUnchecklist(check['id']);
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
                                check['item'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("DELETE"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    deleteCheck(check['id']).then((isSuccess) {
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
                                        // getChecksByCategoriId(widget.categoriId);
                                  },
                                ),
                                FlatButton(
                                  child: Text("CANCEL"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    },
                    title: new Text(
                      check['item'],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        decoration: check['isComplete'] == true
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    )
                    // subtitle: new Text(checkList[index]['id'], style: TextStyle(fontSize: 17),),
                    ),
              );
            }),
      ),
    );
  }

  getChecksByCategoriId() async {
    setState(() {
      isLoading = true;
    });
    Dio dio = new Dio();
    try {
      dio
          .get(
              "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/check?category_id=${widget.categoriId}")
          .then((result) {
        setState(() {
          checkList = result.data['data'];
          checkBoxList = List.generate(result.data['data'].length, (i) {
            return result.data['data'][i]['is_complete'] ? true : false;
          });
        });
      }).catchError((err) {
        print(err);
      });
    } catch (e) {
      return print('error WOOOOYYYYY $e');
    }
  }

  deleteCheck(String id) async {
    Response response;
    Dio dio = new Dio();
    String url =
        "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/check/$id";
    response = await dio.delete(url);
    print('Response status: ${response.statusCode}');
  }

  updateeChecklist(String id) async {
    Response response;
    Dio dio = new Dio();
    String url =
        "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/check/$id/checklist";
    response = await dio.put(url);
    print('Response status: ${response.statusCode}');
  }

  updateeUnchecklist(String id) async {
    Response response;
    Dio dio = new Dio();
    String url =
        "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/check/$id/unchecklist";
    response = await dio.put(url);
    print('Response status: ${response.statusCode}');
  }
}
