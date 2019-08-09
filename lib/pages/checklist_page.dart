import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wedding_planner/model/category.dart';
import 'package:wedding_planner/pages/add_categori_page.dart';
import 'package:wedding_planner/pages/check_screen_page.dart';

class Checklist extends StatefulWidget {
  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  String url =
      "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/";
  String endPoint = "user_id=1vhPGZcsULOYef49lAmIVFT6ITk1";
  List categoriList = new List();
  bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getCategoriesById('id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.blueGrey,
          title: Text("Wedding Checklist"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddListScreen()));
              },
            )
          ],
        ),
        body: Container(
            child: new ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: categoriList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).canPop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext contex) => CheckScreen(
                                    categoriId: categoriList[index]['id'])));
                      },
                      onLongPress: () {
                        showDialog(
                              context: categoriList[index]['id'],
                              barrierDismissible: true, // Allow dismiss when tapping away from dialog
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Delete TODO"),
                                  content: Text("Do you want to delete \"${categoriList[index]['title']}\"?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Cancel"),
                                      onPressed: Navigator.of(context).pop, // Close dialog
                                    ),
                                    FlatButton(
                                      child: Text("DELETE"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        deleteCategori(categoriList[index]['id'])
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
                                        getCategoriesById(
                                            '1vhPGZcsULOYef49lAmIVFT6ITk1');
                                      },
                                    )
                                  ],
                                );
                              });
                      },
                        
                      contentPadding: EdgeInsets.all(10),
                      title: new Text(
                        categoriList[index]['title'],
                        style: TextStyle(fontSize: 17),
                      ),
                      trailing: new Icon(Icons.arrow_right),
                    ),
                  );
                })));
  }

  getCategoriesById(String id) async {
    setState(() {
      isLoading = true;
    });
    Response response;
    Dio dio = new Dio();

    try {
      dio.get('$url/categories?$endPoint').then((result) {
        setState(() {
          categoriList = result.data['data'];
        });
      }).catchError((err) {
        print(err);
      });
      Categories.fromJson(response.data['data']);
    } catch (e) {
      return print('error WOOOOYYYYY $e');
    }
  }

  deleteCategori(String id) async {
    Response response;
    Dio dio = new Dio();
    String url =
        "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/categories:";
    response = await dio.delete(url);
    print('Response status: ${response.statusCode}');
  }
  
  
}

