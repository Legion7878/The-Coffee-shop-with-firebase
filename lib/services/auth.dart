import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycoffeeshop/models/user.dart';
import 'package:mycoffeeshop/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _userfromFirebase(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  Stream<MyUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userfromFirebase(user!));
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userfromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // Sign in  with email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userfromFirebase(user!);
    }catch(e){
      print (e.toString());
      return null;
    }
  }


  // Sign up with email and password

  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateUserData("0", 'New member', 100);
      return _userfromFirebase(user);
    }catch(e){
      print (e.toString());
      return null;
    }
  }

   // Sign out
   Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
   }
}