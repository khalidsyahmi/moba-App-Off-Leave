
import 'package:offleaveppkt/model/supervisor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:offleaveppkt/services/sv_database.dart';

class AuthService2 {

  final FirebaseAuth _authsv = FirebaseAuth.instance;

  // create user obj based on firebase user
  Supervisor _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? Supervisor(svid: user.uid) : null;
  }

  // auth change user stream
  Stream<Supervisor> get user {
    return _authsv.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _authsv.signInAnonymously();
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
      AuthResult result = await _authsv.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String name, String email, String password) async {
    try {
      AuthResult result = await _authsv.createUserWithEmailAndPassword(name: name, email: email, password: password);
      FirebaseUser user = result.user;

          //create new doc for user with the uid
      await DatabaseService4(svid: user.uid).updateUserData( 'Welcome new blood', 'SV user', 50 );
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }


  // sign out
  Future signOut() async {
    try{
      return await _authsv.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}
