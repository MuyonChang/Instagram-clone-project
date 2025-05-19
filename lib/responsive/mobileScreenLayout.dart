import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/LoginScreen.dart';
import 'package:flutter_application_1/provider/user_provider.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimension.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/models.dart' as model;

class Mobilescreenlayout extends StatefulWidget {
  const Mobilescreenlayout({super.key});

  @override
  State<Mobilescreenlayout> createState() => _MobilescreenlayoutState();
}

class _MobilescreenlayoutState extends State<Mobilescreenlayout> {
  String username = ' ';
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(_page){
    pageController.jumpToPage(_page);
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
    model.User? user = Provider.of<UserProvider>(context).getUser;
    if (user == null) {
  // User가 null일 경우 처리
      
}
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        controller: pageController,
       // onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondColor,
            ),
            label: ' ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _page == 1 ? primaryColor : secondColor,
            ),
            label: ' ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: _page == 2 ? primaryColor : secondColor,
            ),
            label: ' ',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? primaryColor : secondColor,
            ),
            label: ' ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondColor,
            ),
            label: ' ',
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
