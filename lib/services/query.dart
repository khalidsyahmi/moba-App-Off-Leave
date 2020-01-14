// this is an experiment // please help me // i dont know if i know what i am doing

import 'package:cloud_firestore/cloud_firestore.dart';

class ApprovalService {
  getLatestApproval(String name, String date, String time){
    return Firestore.instance
    .collection('approvalCollection')
    .where('name', isEqualTo: name)
    .where('date', isEqualTo: date)
    .where('time', isEqualTo: time)
    .orderBy('timeStamp', descending: true)
    .getDocuments();
  }

}

// view page

// bool reviewflag = false;

// var reviews;

// @override 
// void initState(){
//   super.initState();
// }

// ReviewService()
//   .getLatestApproval('yuo','3/4/2121','4 am')
//   .then(QuerySnapshot docs) {
//     if (doc.documents.isNotEmpty) {
//       reviewflag = true;
//       reviews = doc.documents[0].data;
//     }
//   }