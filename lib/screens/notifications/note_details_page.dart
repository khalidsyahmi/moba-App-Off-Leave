import 'package:flutter/material.dart';
import 'package:offleaveppkt/home/setting_form.dart';

class NoteDetail extends StatelessWidget {
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

    return Container(
      
    );
  }
}