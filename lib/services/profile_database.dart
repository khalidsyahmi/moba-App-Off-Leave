import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:offleaveppkt/model/profile.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:offleaveppkt/services/authenticate.dart';
// import 'package:offleaveppkt/model/user.dart';
 
class CrudMedthods {    //similar to databseservice{} classes

  final String uid;
  CrudMedthods({ this.uid });

  final AuthService _auth = AuthService();

  final CollectionReference profileCollection = 
    Firestore.instance.collection('profile_Info');

  bool isLoggedIn() {
    if (_auth != null) {
      return true;
    } else {
      return false;
    }
  }
 
  Future<void> addData(profileData) async { // future functions triggers / can be attached to buttons - on pages
    if (isLoggedIn()) {
      Firestore.instance.collection('profile_Info').add(profileData).catchError((e) {
         print(e);
       });
    } else {
      print('You need to be logged in');
    }
  }

  //read data
  getData() async {
    return await Firestore.instance.collection('profile_Info').getDocuments();
  }

  updataData(selectedDoc, newValues) {
      Firestore.instance.collection('profile_Info').document(selectedDoc).updateData(newValues).catchError((onError){
        print(onError);
      });
  } 
}




//  //Leave.dart list from snapshot
//   List<Profile> _profileListFromSnapshot(QuerySnapshot snapshot){
//     return snapshot.documents.map((doc){
//       return Profile(
//         name: doc.data['name'] ?? '',
//         color: doc.data['color'] ?? '-',

//       );
//     }).toList();
//   }

//   //userdata.dart from snapshots
//   UserData _userDataFromSnapShot(DocumentSnapshot snapshot) {
//     return UserData(
//       uid: uid,
//       name: snapshot.data['name'],
//       color: snapshot.data['color'],
//     );
//   }

//   //get leave stream
//   Stream<List<Profile>> get profile {
//     return profileCollection.snapshots()
//     .map(_profileListFromSnapshot);
//   }

//   //get user doc stream
//   Stream<UserData> get userData {
//     return profileCollection.document(uid).snapshots()
//     .map(_userDataFromSnapShot);
//   }





// }