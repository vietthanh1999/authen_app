import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // void signUp(String email, String pass, String name, String phone){
  //   _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass).then((user) {
  //     print(user);
  //   }).catchError((onError) {
  //     // TODO
  //   });
  // }

  // _createUser(String userId, String name, String phone) {
  //   var user = {
  //     "name": name,
  //     "phone": phone,
  //   };

  //   var ref = FirebaseDatabase.instance.reference().child("users");
  //   ref.child(userId).set(user).then((value) {

  //   }).catchError((onError) {

  //   });
  // }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      print("On sign in success");
      onSuccess();
    }).catchError((onError) {
      onSignInError("Sign in faile, please try again");
    });
  }
}
