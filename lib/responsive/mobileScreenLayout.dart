  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/models.dart' as model;

  class Mobilescreenlayout extends StatefulWidget {
    const Mobilescreenlayout({super.key});

    @override
    State<Mobilescreenlayout> createState() => _MobilescreenlayoutState();
  }

  class _MobilescreenlayoutState extends State<Mobilescreenlayout> {
    String username = '';

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      getUsername();
    }

    void getUsername() async {
      DocumentSnapshot snap =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();
              
      print("Firestore 데이터: ${snap.data()}");
      setState(() {
        username = (snap.data() as Map<String, dynamic>)['username'];
      });
    }

    @override
    Widget build(BuildContext context) {
      model.User user = Provider.of<UserProvider>(context).getUser;
      return Scaffold(
        body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0 ),
          width: double.infinity,
          child: Column(
            children: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(user.username),
                ],
              ),
              
            
          ],
        ),
      ),
      
      
    ));

  }
}
