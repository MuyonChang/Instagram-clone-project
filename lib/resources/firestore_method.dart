import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/post.dart';
import 'package:flutter_application_1/resources/stroage_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethod{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  //upload post 
  Future<String> uploadPost(
   String description,
   String uid,
   Uint8List file,
   String username,
   String profImage,    
  ) async{
    String res = "some error occurred";
    try{
      String photoUrl = await StroageMethod().uploadImageToStorage('posts', file, true);
      String postId = Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],

      );
      _firestore.collection('posts').doc(postId).set(post.toJson(),);
      res = "success";
    } catch(err){
      res = err.toString();
    }
    return res;
  }
}