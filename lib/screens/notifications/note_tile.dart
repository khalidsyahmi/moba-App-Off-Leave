import 'package:flutter/material.dart';
import 'package:offleaveppkt/model/leaveData.dart';
import 'package:offleaveppkt/home/setting_form.dart';

class NoteTile extends StatelessWidget {

  final LeaveData leaveData;
  NoteTile({ this.leaveData });

  @override
  Widget build(BuildContext context) {

    void _showApprovalSheet(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

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

          dense: true,
          enabled: true,
          title: Text(leaveData.motive),
          subtitle: Text('Leave date: ${leaveData.date2} at time: ${leaveData.time2}'),
          onTap: () => _showApprovalSheet(),
        ),
      ),
    );
  }
}
