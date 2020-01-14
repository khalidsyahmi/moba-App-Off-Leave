import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:offleaveppkt/model/supervisor.dart';

class DatabaseService4 {

  final String svid;
  DatabaseService4({ this.svid });

// collection referrence
  final CollectionReference supervisorCollection =
      Firestore.instance.collection('supervisor');

//ref docs and updatedata from user.dart uid
  Future updateUserData(String name, String date, int time) async {
    return await supervisorCollection.document(svid).setData({
      //map
      'name': name,
      'date': date,
      'time': time,
    });
  }

  //Approval list from snapshot of approval collection 
  List<Supervisor> _supervisorListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Supervisor(
        name: doc.data['name'] ?? '-',
        date: doc.data['date'] ?? '-',
        time: doc.data['time'] ?? '0',


      );
    }).toList();
  }

  //svuser data from snapshots
  Supervisor _supervisorFromSnapShot(DocumentSnapshot snapshot) {
    return Supervisor(
      svid: svid,
      name: snapshot.data['name'],
      date: snapshot.data['date'],
      time: snapshot.data['time']
    );
  }

  //get Supervisor stream
  Stream<List<Supervisor>> get supervisor {
    return supervisorCollection.snapshots()
    .map(_supervisorListFromSnapshot);
  }

  //get user doc stream
  Stream<Supervisor> get user {
    return supervisorCollection.document(svid).snapshots()
    .map(_supervisorFromSnapShot);
  }

}


