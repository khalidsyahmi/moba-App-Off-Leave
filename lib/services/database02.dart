import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:offleaveppkt/model/leaveData.dart';
import 'package:offleaveppkt/model/user.dart';


// experimental collection  // successful database service
class DatabaseService2 {

  final String uid;
  DatabaseService2({ this.uid });

// collection referrence
  final CollectionReference leaveFormCollection =
  Firestore.instance.collection('leaveData');

// collection referrence
  final CollectionReference approvalFormCollection =
  Firestore.instance.collection('approval');


//ref docs and updatedata  //update leaveForm

  Future updateUserData(String motive, String date2, String time2) async {
    return await leaveFormCollection.document(uid).setData({

      'motive': motive,
      'date2': date2,
      'time2': time2,
    });
  }


  //Leave list from snapshot **
  List<LeaveData> _leaveDataListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return LeaveData(
        motive: doc.data['motive'] ?? '-',
        date2: doc.data['date2'] ?? '-',
        time2: doc.data['time2'] ?? '-'
      );
    }).toList();
  }


  //user data from snapshots 
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      motive: snapshot.data['motive'],
      date2: snapshot.data['date2'],
      time2: snapshot.data['time2']
    );
  }

  // get leaveData stream **
  Stream<List<LeaveData>> get leaveData {
    return leaveFormCollection.snapshots()
    .map(_leaveDataListFromSnapshot);
  }

  // //get user doc stream   // leaveForm
  Stream<UserData> get userData {
    return leaveFormCollection.document(uid).snapshots()
    .map(_userDataFromSnapShot);
  }
  
  

}