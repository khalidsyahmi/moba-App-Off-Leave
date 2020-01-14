import 'package:flutter/material.dart';
import 'package:offleaveppkt/screens/notifications/approval_sheet.dart';
import 'package:offleaveppkt/model/leaveData.dart';
class NoteDetail extends StatelessWidget {
  
  final LeaveData leaveData;
  NoteDetail(String noteDetail, { this.leaveData }); // retrive leaveData and pageroute

  @override
  Widget build(BuildContext context) {

    void _showApprovalSheet(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: ApprovaSheet(),
        );
      });
    }

    return SafeArea(
          child: Scaffold(
            appBar: new AppBar(
              title: new Text('Maklumat Borang Staff'),
              backgroundColor: Colors.orange[400],
              elevation: 0.0,
            ), 
            body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height, 
              padding:EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage('assets/3xl.png'),
              fit: BoxFit.cover)
            ),
            child: Column(
              children: <Widget>[
                Card(
                  color: Colors.orange,
                  margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0 ),
                  child: ListTile(

                    // leading: CircleAvatar(
                    //   radius: 25.0,
                    //   backgroundColor: Colors.blue[leaveData.time],
                    //   //backgroundImage: AssetImage('assets/circle-border.jpg'),
                    // ),
                    dense: true,
                    enabled: true,
                    // title: Text(leaveData.motive),
                    // subtitle: Text('Leave date: ${leaveData.date2} at time: ${leaveData.time2}'),

                    
                    // worst come to worst just recreate a dummy data
                  )
                ),

                SizedBox(height: 25.0),
                RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Pengesahan',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _showApprovalSheet()
                )
              ],
            ),
          ),
        ),
      ),
    );

  }//build
}//NoteDetail