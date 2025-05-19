import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/LoginScreen.dart';
import 'package:flutter_application_1/provider/user_provider.dart';
import 'package:flutter_application_1/responsive/mobileScreenLayout.dart';
import 'package:flutter_application_1/responsive/responsive_Layout.dart';
import 'package:flutter_application_1/responsive/webScreenLayout.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDfBYrzEqdwkGTn4SW-rKnbdxjtEi41or0",
        appId: "1:60169068751:web:adcedf527bbdfc230ad7ba",
        messagingSenderId: "60169068751",
        projectId: "instagram-e7cd3",
        storageBucket: "instagram-e7cd3.firebasestorage.app",
      ),
    );
  }

  if (Platform.isAndroid) {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: 'Instagram clone',

        home: StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  webScreenLayout: Webscreenlayout(),
                  mobileScreenLayout: Mobilescreenlayout(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
