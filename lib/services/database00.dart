import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:offleaveppkt/model/user.dart';
import 'package:offleaveppkt/model/credentials.dart';

class DatabaseService0 {

  final String uid;
  DatabaseService0({ this.uid});

// collection referrence
  final CollectionReference credentialsCollection =
      Firestore.instance.collection('credentials');

//ref docs and updatedata from existing data + update button
  Future registerUserData(String name, String email, String password) async {
    return await credentialsCollection.document(uid).setData({
      //map
      'name': name,
      'email': email,
      'password': password,
    });
  }

  //Leave.dart list from snapshot in firestore
  List<Creds> _credListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Creds(
        name: doc.data['name'] ?? '-',
        email: doc.data['email'] ?? '-',
        password: doc.data['password'] ?? '-'
      );
    }).toList();
  }

  //userdata.dart from snapshots
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
      uid:uid,
      name: snapshot.data['name'],
      email: snapshot.data['date'],
      password: snapshot.data['password']
    );
  }

  //get leave stream
  Stream<List<Creds>> get cred {
    return credentialsCollection.snapshots()
    .map(_credListFromSnapshot);
  }

  //get user doc stream // only return uid ??
  Stream<UserData> get userData {
    return credentialsCollection.document(uid).snapshots()
    .map(_userDataFromSnapShot);
  }

}
