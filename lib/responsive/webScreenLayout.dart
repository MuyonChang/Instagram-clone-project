import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Webscreenlayout extends StatefulWidget {
  const Webscreenlayout({super.key});

  @override
  State<Webscreenlayout> createState() => _WebscreenlayoutState();
}

class _WebscreenlayoutState extends State<Webscreenlayout> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
  icon: Icon(Icons.logout),
  onPressed: () async {
    await FirebaseAuth.instance.signOut();
  },
);
  }
}
