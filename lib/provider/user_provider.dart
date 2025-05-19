import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/models.dart';
import 'package:flutter_application_1/resources/auth_methods.dart';

  class UserProvider with ChangeNotifier{
    User? _user;
    User? get getUser => _user; //프라이빗 함수로선언
    final AuthMethods _authMethods = AuthMethods(); 
    
    Future <void> refreshUser() async{{
      User user = await _authMethods.getUserDetails();
      _user = user;
      notifyListeners();
    }}
  }