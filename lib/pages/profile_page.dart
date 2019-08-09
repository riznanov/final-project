import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wedding_planner/model/profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
 
}

class _ProfilePageState extends State<ProfilePage> {
    Profile newProfile = new Profile(); 
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: Text("Profile"),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Masukan Nama anda',
                  labelText: 'Nama Anda',
                ),
                inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                 validator: (val) => val.isEmpty ? '' : null,
                 onSaved: (val) => newProfile.name = val,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Masukan Nama pasangan anda',
                  labelText: 'Nama Pasangan',
                ),
                inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                 validator: (val) => val.isEmpty ? '' : null,
                 onSaved: (val) => newProfile.name2 = val,
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.calendar_today),
                        hintText: 'Masukan tanggal pernikahan',
                        labelText: 'Tanggal Pernikahan',
                      ),
                      controller: _controller,
                      keyboardType: TextInputType.datetime,
                      validator: (val) =>
                          isValidDay(val) ? null : 'Not a valid date',
                       onSaved: (val) => newProfile.marrieddate = convertToDate(val),
                    ),
                  ),
                  new IconButton(
                    icon: new Icon(Icons.calendar_view_day),
                    tooltip: 'Pilih Tanggal',
                    onPressed: (() {
                      _chooseDate(context, _controller.text);
                    }),
                  )
                ],
              ),
              new Container(
                padding: const EdgeInsets.only(top: 20, left: 40.0),
                child: new RaisedButton(
                  child: const Text("Submit"),
                  onPressed: _submitForm,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final TextEditingController _controller = new TextEditingController();
  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 2050 && initialDate.isAfter(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        lastDate: new DateTime(2050),
        firstDate: new DateTime(2019));

    if (result == null) return;

    setState(() {
      _controller.text = new DateFormat.yMd().format(result);
    });
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  bool isValidDay(String marrieddate) {
    if (marrieddate.isEmpty) return true;
    var d = convertToDate(marrieddate);
    return d != null && d.isAfter(new DateTime.now());
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); 

      print('Form save called, newContact is now up to date...');
      print('Nama anda: ${newProfile.name}');
      print('Nama pasangan anda: ${newProfile.name2}');
      print('Tanggal Pernikahan: ${newProfile.marrieddate}');
      
      print('TODO - we will write the submission part next...');
    }
  }
    void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message)));
  }
}
