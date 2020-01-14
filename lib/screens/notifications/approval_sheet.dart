import 'package:flutter/material.dart';
import 'package:offleaveppkt/services/approval_database.dart';
import 'package:offleaveppkt/shared/deConstants.dart';
import 'package:offleaveppkt/model/user.dart';
// import 'package:offleaveppkt/services/database02.dart';
import 'package:offleaveppkt/shared/loading.dart';
import 'package:provider/provider.dart';


class ApprovaSheet extends StatefulWidget {
  @override
  _ApprovaSheetState createState() => _ApprovaSheetState();
}

class _ApprovaSheetState extends State<ApprovaSheet> {

  final _formKey = GlobalKey<FormState>();
  final List<String> approval = ['Sahkan','Tidak Sahkan'];

  // form values
  String _appId;
  String _currentApproval;
  String _currentStatus;
  String _currentMemo;

  bool loading = false; 

  @override
  Widget build(BuildContext context) {
   final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService3(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            UserData userData = snapshot.data;

              return loading ? Loading() : Form(
                key: _formKey,
                child: Column( 
                  children: <Widget>[
                    Text(
                      'Sahkan Permohonan borang',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.memo, // 
                      decoration: textInputDecoration,
                      validator: (val) => val.isEmpty ? 'Masukkan alasan' : null,
                      onChanged: (val) => setState(() => _currentMemo = val),
                    ),
                    SizedBox(height: 20.0),
                    //dropdown ff
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentApproval ?? userData.approvals, // how ??
                      items: approval.map((approval) {
                        return DropdownMenuItem(
                          value: approval,
                          child: Text('$approval'), // Approval value
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentApproval = val),
                    ),

                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          ' Ubah ',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);       // set loading      
                            _currentStatus = "Done"; // hardcoded for now
                            await DatabaseService3(uid: user.uid).newApproval(
                              // all conditional parameters required
                              // position values here carefully => will confuse with future setdata in dbservice2
                              _appId ?? user.uid, 
                              _currentApproval ?? userData.approvals, 
                              _currentStatus ?? userData.status,
                              _currentMemo ?? userData.memo, 
                              
                            );
                            Navigator.pop(context);
                          }
                        }),
                  ],
                ),
              );
          } else {
            return Loading();
          }
        });
  }
}