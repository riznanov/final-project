import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
// import 'package:wedding_planner/pages/check_screen_page.dart';

class AddCheckScreen extends StatefulWidget {
  final String categoriId;

  AddCheckScreen({this.categoriId});
  @override
  _AddCheckScreenState createState() => _AddCheckScreenState();
}

class _AddCheckScreenState extends State<AddCheckScreen> {
 final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // String url =
  //     "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/check/:categori_id=${widget.categoriId}";
 TextEditingController checkController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        title: Text('Checklist Baru', style: TextStyle(color: Colors.white),),
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
              controller: checkController,
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
              if (checkController.text.isEmpty) {
              final snackBar = SnackBar(
                content: Text('Anda belum memasukan checklist baru'),
              );
              Scaffold.of(context).showSnackBar(snackBar);
              _scaffoldKey.currentState.showSnackBar(snackBar);
            } else {
              postCheck();
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
  postCheck() async{
    Response response;
    Dio dio = new Dio();
    String url = "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/check/:${widget.categoriId}";
    response = await dio.post(url, data: {
      "item": checkController.text
    });
    print('Response status: ${response.statusCode}');
  }
}