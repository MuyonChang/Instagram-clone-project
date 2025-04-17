import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/TextField.dart';
import 'package:flutter_application_1/resources/auth_methods.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  _SignupscreenState createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool isloading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 1, child: Container()),
              SvgPicture.asset(
                'lib/assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                            "https://i.stack.imgur.com/l60Hf.png",
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo, size: 30),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Enter your Username',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),
              const SizedBox(height: 20),
              TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  String res = await AuthMethods().signUpUser(
                    email: _emailController.text,
                    password: _passwordController.text,
                    username: _usernameController.text,
                    bio: _bioController.text,
                    file: _image!,
                    
                  );
                  
                   showSnackBar(res, context);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    color: blueColor,
                  ),
                  child: isloading ? Center(child: CircularProgressIndicator(color:primaryColor)) : Text('Log in'),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(flex: 1, child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 50,
                      horizontal: 15,
                    ),
                    child: const Text("Don't have an account?"),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 33),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}