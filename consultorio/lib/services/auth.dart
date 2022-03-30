import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebaseUser
  MyUser? _userfromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //auth change user stream

  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userfromFirebaseUser(user));
  }

  //sign in anon
  Future SignInAnon() async {
    try {
      //Authresult deprecated ==> UserCredential
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userfromFirebaseUser(user);
    } catch (e) {
      print('Error : ' + e.toString());
      return null;
    }
  }

  //sign out
  Future SignOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('Error : ' + e.toString());
      return null;
    }
  }
}
