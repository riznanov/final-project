import 'package:flutter/material.dart';
import 'package:wedding_planner/pages/checklist_page.dart';
import 'package:wedding_planner/pages/profile_page.dart';
import 'package:wedding_planner/pages/task_screen_page.dart';
import 'package:wedding_planner/service/authentication.dart';
import 'package:wedding_planner/utils/datetime_utils.dart';



class HomePage extends StatefulWidget {
    HomePage({Key key, this.auth, this.userId, this.onSignOut})
      : super(key: key);

  final BaseAuth auth;
  final String userId;
  final VoidCallback onSignOut;


  @override
  _HomePageState createState() => _HomePageState();
  
   currentDay(BuildContext context) {
    return DateTimeUtils.currenDay;
  }
}


class _HomePageState extends State<HomePage> {
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignOut();
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
  
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Wedding Planner',style: TextStyle(fontSize: 30) , ),
              decoration: BoxDecoration(
              color: Colors.blueGrey
              ),
            ),
            ListTile(
               title: Text("To Do"),
                 onTap: (){
                   Navigator.of(context).canPop();
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TaskScreen()));
                 },
            ),
                ListTile(
                 title: Text("Wedding Checklist"),
                 onTap: (){
                  Navigator.of(context).canPop();
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Checklist()));
                 },
               ),
               ListTile(
                 title: Text("Profile"),
                 onTap: (){
                  Navigator.of(context).canPop();
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext contex) => ProfilePage()));
                 
                 },
               ),

               ListTile(
                 title: Text("Log Out"),
                  onTap: _signOut,
                ),
                   ],
                     ),
                       ),
                        backgroundColor: Colors.white,
                         appBar:  AppBar(
                           title: Text("Wedding Planner"),
                           centerTitle: true,
                           elevation: 0.0,
                           backgroundColor: Colors.blueGrey
                         ),
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                           margin: EdgeInsets.only(top: 0.0, left: 56.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                               Container(
                                 margin: EdgeInsets.only(top: 22),
                                 child: Text('${widget.currentDay(context)}',style: Theme.of(context).textTheme.headline.copyWith(color: Colors.black),),
                               ),
                             Text('${DateTimeUtils.currentDate} ${DateTimeUtils.currentMonth} ${DateTimeUtils.year}',style: Theme.of(context).textTheme.title.copyWith(color: Colors.black.withOpacity(0.7)),),
                             Container(
                               height: 16.0,
                             ),
                              Container(height: 16.0),
                             ],
                           ),
                          ),
                          Container(
                              margin: EdgeInsets.all(50.0),
                              child: Image.network("http://www.evelynclarkweddings.com/wp-content/uploads/2013/03/dont-worry-about-perfect-wedding1.png"),
                          ),
                          
                        ],
                      ),
                     );
                   }
                 
}
