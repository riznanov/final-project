import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wedding_planner/pages/checklist_page.dart';
// import 'package:wedding_planner/model/category.dart';

class AddListScreen extends StatefulWidget {
  @override
  _AddListScreenState createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  String url =
      "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/categories/";
  // String endPoint = "user_id=8lrVGc7Y1HO1qw7xQg5tilJ7faQ2";
  bool isLoading;
  String newCategori;
  String userId;
  TextEditingController categoriController;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void dispose() {
    super.dispose();
    categoriController.dispose();
  }

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   newCategori = "";
    //  });
    categoriController = TextEditingController();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tambah Kategori',
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
              'Kategori apa yang Anda rencanakan?',
              style: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0),
            ),
            Container(
              height: 16.0,
            ),
            TextFormField(
              controller: categoriController,
              autofocus: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Kategori...',
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
          label: Text("Tambah Kategori"),
          onPressed: () {
            if (categoriController.text.isEmpty) {
              final snackBar = SnackBar(
                content: Text('Anda belum memasukan kategori apapun'),
              );
              Scaffold.of(context).showSnackBar(snackBar);
              _scaffoldKey.currentState.showSnackBar(snackBar);
            } else {
              postCategory();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Checklist()));
            }
          },
        );
      }),
    );
  }

  postCategory() async {
    Response response;
    Dio dio = new Dio();

    response = await dio.post(url, data: {
      "user_id": "1vhPGZcsULOYef49lAmIVFT6ITk1",
      "title": categoriController.text
    });
    print('Response status: ${response.statusCode}');
  }
}
