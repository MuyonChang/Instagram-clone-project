import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/resources/stroage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // sign up user 

  Future<String> signUpUser({
    required String email,
    required String password, 
    required String username, 
    required String bio, 
    required Uint8List file,
  })async{
    String res = "Some error occurred";
    try{
      if(email.isNotEmpty || password.isNotEmpty||username.isNotEmpty||bio.isNotEmpty||file!=null)
      {
        // register user 
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        
        print(cred.user!.uid); //generate user id 

        String photoUrl = await StroageMethod().uploadImageToStorage('profilePics', file, false);

        await _firestore.collection('users').doc(cred.user!.uid).set({
            'username': username,
            'uid': cred.user!.uid,
            'email': email,
            'bio': bio,
            'following':[],
            'followers':[],
            'photoUrl':photoUrl,
        });
        res = 'succeed';
      }
      }catch(err){{
        res = err.toString();
      }
      }
      return res;
    }
  
}
