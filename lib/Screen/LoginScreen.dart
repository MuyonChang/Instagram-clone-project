import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/SignupScreen.dart';
import 'package:flutter_application_1/Widgets/TextField.dart';
import 'package:flutter_application_1/resources/auth_methods.dart';
import 'package:flutter_application_1/responsive/mobileScreenLayout.dart';
import 'package:flutter_application_1/responsive/responsive_Layout.dart';
import 'package:flutter_application_1/responsive/webScreenLayout.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isloading = false;
  LoginScreen({super.key});

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signUpUser(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const Signupscreen()));
  }

  void loginUser(BuildContext context) async {
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder:
              (context) => const ResponsiveLayout(
                webScreenLayout: Webscreenlayout(),
                mobileScreenLayout: Mobilescreenlayout(),
              ),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
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

              const SizedBox(height: 64),

              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.emailAddress,
                isPass: true,
              ),
              const SizedBox(height: 20),

              InkWell(
                onTap: () => loginUser(context),
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
                  child: const Text('Log in'),
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
                    child: Text("Don't have an account?"),
                  ),
                  GestureDetector(
                    onTap: () {
                      signUpUser(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 33),
                      child: Text(
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
