
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:offleaveppkt/model/approval.dart';
import 'package:offleaveppkt/model/user.dart';

class DatabaseService3 {

  final String uid;
  DatabaseService3({ this.uid });

// collection referrence
  final CollectionReference approvalFormCollection =
      Firestore.instance.collection('approval');


  // dbserve2 newApproval *** presets/ update

  Future newApproval(String appId, String approvals, String status, String memo) async {
    return await approvalFormCollection.document(uid).setData({

        'appId' : appId,
        'approvals' : approvals,
        'status' : status,
        'memo' : memo,
  
    });
  }

  
  //get Approval list from snapshot ***
  List<Approval> _approvalListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Approval(
        appId: doc.data['appId'] ?? '-',
        approvals: doc.data['approvals'] ?? '-',
        status: doc.data['status'] ?? '-',
        memo: doc.data['memo'] ?? '-'
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

    // get leaveData stream ***
  Stream<List<Approval>> get approval {
    return approvalFormCollection.snapshots()
    .map(_approvalListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return approvalFormCollection.document(uid).snapshots()
    .map(_userDataFromSnapShot);
  }

}


