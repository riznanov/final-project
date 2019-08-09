import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wedding_planner/pages/todo_screen_page.dart';

class AddTodoScreen extends StatefulWidget {
  final String taskId;

  AddTodoScreen({this.taskId});
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController todoController;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        title: Text('Tambah Todo', style: TextStyle(color: Colors.white),),
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
            Text('What task are you planning to perfrom?', style: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.w600,
              fontSize: 16.0),),
            Container(height: 16.0,),
            TextFormField(
              controller: todoController,
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
      floatingActionButton: Builder(
        builder: (BuildContext contex){
          return FloatingActionButton.extended(
            icon: Icon(Icons.add),
            backgroundColor: Color(0xFF009688),
            label: Text("Tambah Checklis"),
            onPressed: (){
              if (todoController.text.isEmpty) {
              final snackBar = SnackBar(
                content: Text(''),
              );
              Scaffold.of(context).showSnackBar(snackBar);
              _scaffoldKey.currentState.showSnackBar(snackBar);
            } else {
              postTodo();
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    content: Text("Data berhasil disimpan"),
                    actions: <Widget>[
                        FlatButton(
                        child: Text("Kembali"),
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext contex)=> TodoScreen()));
                        }
                      )
                    ],
                  );                 
                }
              );
            }
            }, 
          );
        }
      ),
      
    );
  }
  postTodo() async{
    Response response;
    Dio dio = new Dio();
    String url = "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/check/:${widget.taskId}";
    response = await dio.post(url, data: {
      "item": todoController.text
    });
    print('Response status: ${response.statusCode}');
  }
}