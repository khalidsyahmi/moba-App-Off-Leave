import 'package:flutter/material.dart';
import 'package:offleaveppkt/screens/notifications/note_list.dart';
import 'package:offleaveppkt/model/leaveData.dart';
import 'package:offleaveppkt/services/database02.dart';
import 'package:provider/provider.dart';


class Approval extends StatefulWidget {

final String title;
Approval(this.title);

  @override
  _ApprovalState createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<LeaveData>>.value(
      value: DatabaseService2().leaveData,

      child: SafeArea(
              child: Scaffold(
          backgroundColor: Colors.red[400],
          appBar: AppBar(
            title: Text('Approval notifications'),
            backgroundColor: Colors.green[500],
            elevation: 0.0,
          ),

          body: Container(
            child: FilledList()

          ),

        ),
      ),
    );
  }
}