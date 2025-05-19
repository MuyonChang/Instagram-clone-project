import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/resources/stroage_method.dart';
import 'package:flutter_application_1/models/models.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // sign up user

  Future<model.User> getUserDetails() async{
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);

    
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty 
          
          ) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        print(cred.user!.uid); //generate user id

        String photoUrl = await StroageMethod().uploadImageToStorage(
          'profilePics',
          file,
          false,
        );

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          bio: bio,
          following: [],
          followers: [],
          photoUrl: photoUrl,
          email: email,
        );
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
        res = 'succeed';
      }
    } catch (err) {
      {
        res = err.toString();
      }
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'success';
      } else {
        res = 'please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
