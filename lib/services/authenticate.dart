import 'package:offleaveppkt/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:offleaveppkt/services/database01.dart';
import 'package:offleaveppkt/services/database00.dart';

import 'approval_database.dart';
// import 'database02.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null; // if not null return uid from User.dart
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String name ,String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword( name: name, email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService0(uid: user.uid).registerUserData( name , '${user.email}', password); // took forever // cant add custom value in fb auth
      await DatabaseService(uid: user.uid).updateUserData( 'Welcome new blood', 'Regular user', 100 ); //create new doc for user with the uid
      // await DatabaseService2(uid: user.uid).updateUserData( '-', '-', '-' ); //create new doc for user with the uid
      await DatabaseService3(uid: user.uid).newApproval( user.uid , 'none created', 'pending', 'no comment'); // dbserve2 newApproval ***
      
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //  // create new form status to pending                        // nothing to see here
  // Future createNewForm(String email, String password) async {
  //   try {
  //     AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  //     FirebaseUser user = result.user;

  //         //create new doc for user with the uid
  //     return _userFromFirebaseUser(user);
  //   } catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}