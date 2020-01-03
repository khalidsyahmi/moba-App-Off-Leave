import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:offleaveppkt/model/leaveData.dart';
import 'note_tile.dart';



class FilledList extends StatefulWidget {

  @override
  _FilledListState createState() => _FilledListState();
}

class _FilledListState extends State<FilledList> {
  @override
  Widget build(BuildContext context) {

   final leaveData = Provider.of<List<LeaveData>>(context) ?? []; //empty array

    return ListView.builder(
      itemCount: leaveData.length,
      itemBuilder: (context, index){
        return NoteTile(leaveData: leaveData[index]);
      },
    );

  }

}