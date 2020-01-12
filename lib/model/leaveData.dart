// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveData {

  final String motive;
  final String date2;
  final String time2;

  LeaveData({ this.motive, this.date2, this.time2 });

  
  // create note obj. from a firebase snapshot

  LeaveData.fromTileSnapshot(DocumentSnapshot snapshot) :
   
      motive = snapshot['name'],
      date2= snapshot['color'],
      time2 = snapshot['status'];


}