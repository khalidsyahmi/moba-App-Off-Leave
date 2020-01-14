import 'package:flutter/material.dart';
import 'package:offleaveppkt/shared/deConstants.dart';
import 'package:offleaveppkt/model/user.dart';
// import 'package:offleaveppkt/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:offleaveppkt/services/database02.dart';

class LeaveForm extends StatefulWidget {
  final String title; //route param
  LeaveForm(this.title);

  @override
  _LeaveFormState createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  // final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); // identify our form
  // bool loading = false;

  // form values
  String _currentMotive;
  String _currentDate2;
  String _currentTime2;

  // date n time Picker values
  DateTime _dateTime;
  TimeOfDay _timeOfDayA;
  TimeOfDay _timeOfDayB;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService2(uid: user.uid).userData,
        builder: (context, snapshot) {
          // if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return SafeArea(
              child: Scaffold(
                appBar: new AppBar(
                  title: new Text('Leave Form'),
                  backgroundColor: Colors.orange[400],
                  elevation: 0.0,
                ),
                body: SingleChildScrollView(
                  //scrooll widget
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height, //

                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/3xl.png'),
                      fit: BoxFit.cover,
                    )),
                    child: new Form(
                      key: _formKey,
                      child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center, // try
                          children: <Widget>[
                            Container(
                              decoration:
                                  BoxDecoration(color: Colors.deepOrange[600]),
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
                              child: Text(
                                'Update your Motive',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              // initialValue: userData.motive,
                              decoration: textInputDecoration,  // import tff deconstants.dart
                              validator: (val) =>
                                  val.isEmpty ? 'Enter a motive' : null,
                              onChanged: (val) =>
                                  setState(() => _currentMotive = val),
                            ),
                            SizedBox(height: 25.0),
                            Container(
                              decoration:
                                  BoxDecoration(color: Colors.deepOrange[600]),
                              child: Text(
                                _dateTime == null
                                    ? 'No date picked yet'
                                    : _dateTime.toString(),
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
                            ),
                            SizedBox(height: 5.0),
                            RaisedButton(
                              color: Colors.pink[400],
                              child: Text('Pick a date',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: _dateTime == null
                                            ? DateTime.now()
                                            : _dateTime, // remember last pick
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2077))
                                    .then((date) {
                                  setState(() {
                                    _dateTime = date;
                                    _currentDate2 = _dateTime.toString();
                                  });
                                }); //onPressed
                              },
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              decoration:
                                  BoxDecoration(color: Colors.deepOrange[600]),
                              child: Text(
                                _timeOfDayA == null
                                    ? 'No Time picked yet'
                                    : _timeOfDayA.toString(),
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
                            ),
                            SizedBox(height: 5.0),
                            RaisedButton(
                              color: Colors.pink[400],
                              child: Text('Pick a Time',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: _timeOfDayA == null
                                      ? TimeOfDay.now()
                                      : _timeOfDayA, // remember last pick
                                ).then((time) {
                                  setState(() {
                                    _timeOfDayA = time;
                                    //  _currentTime2 = _timeOfDayA;
                                  });
                                }); //onPressed
                              },
                            ),
                            Container(
                              decoration:
                                  BoxDecoration(color: Colors.deepOrange[600]),
                              child: Text(
                                _timeOfDayB == null
                                    ? 'No Time picked yet'
                                    : _timeOfDayB.toString(),
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
                            ),
                            SizedBox(height: 5.0),
                            RaisedButton(
                              color: Colors.pink[400],
                              child: Text('Pick a Time',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: _timeOfDayB == null
                                      ? TimeOfDay.now()
                                      : _timeOfDayB, // remember last pick
                                ).then((time) {
                                  setState(() {
                                    _timeOfDayB = time;
                                    //  _currentTime2 = _timeOfDayB.toString();
                                  });
                                }); //onPressed
                              },
                            ),
                            SizedBox(height: 20.0),
                            RaisedButton(
                                color: Colors.pink[400],
                                child: Text(
                                  'Update',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_timeOfDayB.hour - _timeOfDayA.hour <= 2.00 ) {
                                    _currentTime2 = _timeOfDayA.toString();
                                    // _currentTime2 = _timeOfDayB.toString();

                                    if (_formKey.currentState.validate()) {
                                      await DatabaseService2(uid: user.uid)
                                          .updateUserData(
                                              _currentMotive ?? userData.motive,
                                              _currentDate2 ?? userData.date2,
                                              _currentTime2 ?? userData.time2

                                              //remove .variables to see if it increments or not
                                              // _currentMotive ?? userData,
                                              // _currentDate2 ?? userData,
                                              // _currentTime2 ?? userData

                                              //diddnt work/ how to increment data with the same uid ?
                                              );

                                      print(_currentMotive);
                                      print(_currentDate2);
                                      print(_currentTime2);

                                      leaveFill(context); //success
                                    }
                                  } else if ( _timeOfDayB.hour - _timeOfDayA.hour > 2.00){
                                    notFilled(context); //failed
                                  }
                                }),
                          ]),
                    ),
                  ),
                ),
              ),
            );
          // } else { 
          //  return Loading();  /// literal piece of shiit idea
          //  }
        });
  } //build method

  void leaveFill(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text('Application Submmitted'),
      content: Text('Please review your verification later'),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        }
        // Navigator.pop(context);
        );
  }

  void notFilled(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text('Application Rejected'),
      content: Text('Please review your period less than 2 hours'),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
} // class LeaveForm
