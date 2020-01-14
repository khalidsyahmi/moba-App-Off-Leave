// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offleaveppkt/model/leaveData.dart';
import 'note_details_page.dart';
// import 'package:offleaveppkt/screens/notifications/note_details_page.dart';
// import 'package:offleaveppkt/home/setting_form.dart';
// import 'package:offleaveppkt/model/profile.dart';

class NoteTile extends StatelessWidget {

  final LeaveData leaveData;
  NoteTile({ this.leaveData });


  @override
  Widget build(BuildContext context) {

    // final note = LeaveData.fromTileSnapshot(context);
    // final noteType = LeaveData.types();

       return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0 ),
        child: ListTile(

          // leading: CircleAvatar(
          //   radius: 25.0,
          //   backgroundColor: Colors.blue[leaveData.time],
          //   //backgroundImage: AssetImage('assets/circle-border.jpg'),
          // ),
          contentPadding: EdgeInsets.fromLTRB(12, 5, 0, 5),
          dense: true,
          enabled: true,
          title: Text(leaveData.motive),
          subtitle: Text('\nLeave date: ${leaveData.date2} \nLeave Time: ${leaveData.time2}'),
          onTap: () {
            Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => NoteDetail('noteDetail')
            )
            ); //push
          }
        ),
      ),
    );
  }
}
