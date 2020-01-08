
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:offleaveppkt/model/approval.dart';
// import 'package:offleaveppkt/model/supervisor.dart';
import 'package:offleaveppkt/model/user.dart';

class DatabaseService3 {

  final String uid;
  DatabaseService3({ this.uid });

// collection referrence
  final CollectionReference approvalCollection =
      Firestore.instance.collection('approval');

//ref docs and updatedata from user.dart uid
  Future updateUserData(String reason, String date, int time) async {
    return await approvalCollection.document(uid).setData({
      //map
      'reason': reason,
      'date': date,
      'time': time,
      // 'memo': memo,
    });
  }

  //Approval list from snapshot of approval collection 
  List<Approval> _leaveListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Approval(
        appId: doc.data['appId'] ?? '-',
        approvals: doc.data['approvals'] ?? '-',
        status: doc.data['status'] ?? false,
        memo: doc.data['memo'] ?? '-',
      );
    }).toList();
  }

  //user data from snapshots
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      reason: snapshot.data['reason'],
      date: snapshot.data['date'],
      time: snapshot.data['time']
    );
  }

  //get Approval stream
  Stream<List<Approval>> get approval {
    return approvalCollection.snapshots()
    .map(_leaveListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return approvalCollection.document(uid).snapshots()
    .map(_userDataFromSnapShot);
  }

}


