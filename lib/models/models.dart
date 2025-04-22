import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String uid;
  final String email;
  final String bio;
  final List following;
  final List followers;
  final String photoUrl;

  const User({
    required this.username,
    required this.uid,
    required this.bio,
    required this.following,
    required this.followers,
    required this.photoUrl, 
    required this.email,
  });

  Map<String , dynamic> toJson()=>{
    "username": username,
    "uid" : uid,
    "bio" : bio,
    "following": following,
    "followers": followers,
    "photoUrl": photoUrl,
    "email":email,
  };


  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      bio: snapshot['bio'],
      following: snapshot['following'],
      followers: snapshot['followers'],
      photoUrl: snapshot['photoUrl'],
      email: snapshot['email'],
    );
  }
}
