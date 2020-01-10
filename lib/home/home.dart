import 'package:flutter/material.dart';
import 'package:offleaveppkt/home/setting_form.dart';
// import 'package:offleaveppkt/screens/task_creator.dart';
import 'package:offleaveppkt/screens/task_creator/task_main.dart';
import 'package:offleaveppkt/services/authenticate.dart'; // lesson 9
import 'package:offleaveppkt/services/database.dart';
import 'package:provider/provider.dart';
import 'package:offleaveppkt/model/leave.dart';
import 'package:offleaveppkt/screens/bottom_sheet/leave_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
 
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Leave>>.value(
      value: DatabaseService().leave,
      child: SafeArea(
              child: Scaffold(
          backgroundColor: Colors.pink[50],
          //drawer here5
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                DrawerHeader(                   
                  decoration: BoxDecoration(      // header custom
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.deepOrange,
                        Colors.deepPurpleAccent
                      ])
                  ),
                  child: Container(
                    child: Column(children: <Widget>[
                      Material(
                        child: Image.asset('assets/logo_usm.png', width: 250, height: 95),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('PPKT Form App',style: TextStyle(color: Colors.white, fontSize: 20.0 ),),
                      )
                    ],
                    ),
                    )),
                SizedBox(height: 5.0),
                CustomListTile(Icons.person, 'Profile', () {
                  Navigator.of(context).pop();                                 //nav to the page       
                  Navigator.of(context).pushNamed("/d");
                }),
                SizedBox(height: 5.0),
                CustomListTile(Icons.dashboard, 'Task Creator', () {
                  // Navigator.of(context).pop();                                 //nav to the page       
                  // Navigator.of(context).pushNamed("/c");
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => MyHomePage('Create Task')
                    ));
                },),
                CustomListTile(Icons.notifications, 'Notification', () {
                  Navigator.of(context).pop();                                 //nav to the page       
                  Navigator.of(context).pushNamed("/b");
                }),
                SizedBox(height: 5.0),
                CustomListTile(Icons.create_new_folder, 'Leave Form', () {
                  Navigator.of(context).pop();                                 //nav to the page       
                  Navigator.of(context).pushNamed("/a");
                },),

              ],
            )
          ), 

          appBar: AppBar(
            title: Text('Home'),
            backgroundColor: Colors.pink[400],
            elevation: 0.0,
            actions: <Widget>[
               // to show a moving sheet
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('settings'),
                onPressed: () => _showSettingsPanel(),
              ),
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),           
            ],
          ),

          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
               image: AssetImage('assets/google-pixel-3.jpg'),
               fit: BoxFit.cover,
               )
            ),
            child: LeaveList()
          ),
        ),
      ),
    );
  }
}

//inkwell drawer and tabs

class CustomListTile  extends StatelessWidget {

  final IconData icon;  
  final String text;
  final Function onTap;

  CustomListTile( this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.orangeAccent.shade400))
        ),
        child: InkWell(
          splashColor: Colors.orangeAccent,
          onTap: onTap,             //cust inst of hrdcoded
          child: Container(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon), //cust inst of hrdcoded
                      Text(text,style: TextStyle(    //cust inst of hrdcoded
                        fontSize: 16.0
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      )
      ,
    );
  }
}