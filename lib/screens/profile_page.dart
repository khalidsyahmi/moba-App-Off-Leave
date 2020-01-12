import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:offleaveppkt/services/profile_database.dart';
// import 'package:offleaveppkt/model/user.dart';
// import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final _sheetKey = GlobalKey<FormState>(); // identify our form

  // String uid;
  String namePerson;
  String colorPerson;

  QuerySnapshot cars;

  CrudMedthods crudObj = new CrudMedthods();

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            key: _sheetKey,  // i hope this works
            title: Text('Add Data', style: TextStyle(fontSize: 15.0)),
            content: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Enter yer Name'),
                  onChanged: (value) {
                    this.namePerson = value;
                  },
                ),
                SizedBox(height: 5.0),
                TextField(
                  decoration: InputDecoration(hintText: 'Enter yer color'),
                  onChanged: (value) {
                    this.colorPerson = value;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Add'),
                textColor: Colors.blue,
                onPressed: () async {
                  Navigator.of(context).pop();
                  crudObj.addData({
                    'name': this.namePerson,
                    'color': this.colorPerson

                        // if (_sheetKey.currentState.validate()) {
                        //   var userData;
                        //   var user;
                        //     await CrudMedthods(uid: user.uid).addData(
                        //     namePerson ?? userData.name,
                        //     colorPerson ?? userData.color,
                        //     // _currentTime2 ?? userData.time2
                        //   )
                  })
                    .then((result) {
                      dialogTrigger(context);
                    }).catchError((e) {
                      print(e);
                    });
                  }
                
              )
            ],
          );
        });
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Job Done', style: TextStyle(fontSize: 15.0)),
            content: Text('Added'),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }


  @override
  void initState() {
    crudObj.getData().then((results) {
      setState(() {
        cars = results;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

  // final user = Provider.of<User>(context);

    // return StreamBuilder<UserData>(
    //   stream: CrudMedthods(uid: user.uid).userData,
    //   builder: (context, snapshot) {

        //UserData userData = snapshot.data;

        return new Scaffold(
            appBar: AppBar(
              title: Text('Dashboard'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    addDialog(context);
                  },
                )
              ],
            ),
            body: _carList());
      }
    // );
  // }

    Widget _carList() {
    if (cars != null) {
      return ListView.builder(
        itemCount: cars.documents.length,
        padding: EdgeInsets.all(5.0),
        itemBuilder: (context, index) {
          return new ListTile(
            title: Text(cars.documents[index].data['name']),
            subtitle: Text(cars.documents[index].data['color']),
          );
        },
      );
    } else {
      return Text('Loading, Please wait..');
    }
  }

}//end of profile page


