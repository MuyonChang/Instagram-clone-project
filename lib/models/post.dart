import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl, 
    required this.profImage,
    required this.likes,
  });

  Map<String , dynamic> toJson()=>{
    "description": description,
    "uid" : uid,
    "username" : username,
    "postId": postId,
    "datePublished": datePublished,
    "postUrl": postUrl,
    "profImage":profImage,
    "likes": likes,
  };


  static Post fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      profImage: snapshot['profImage'],
      postUrl: snapshot['postUrl'],
      likes: snapshot['likes'],
    );
  }
}
