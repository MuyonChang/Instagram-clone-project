import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/TextField.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_svg/svg.dart';

class Signupscreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
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
              Flexible(child: Container(), flex: 1),
              SvgPicture.asset(
                'lib/assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage("https://www.google.com/url?sa=i&url=https%3A%2F%2Fnews.sbs.co.kr%2Fnews%2FendPage.do%3Fnews_id%3DN1006256590&psig=AOvVaw39aaDG2aL3lVU_Kbwst64a&ust=1744882727019000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCNjZ8uqg3IwDFQAAAAAdAAAAABAI"),
                  ),
                  Positioned(
                    bottom:-15 ,
                    left: 80,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.add,size: 50,))),
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
                textInputType: TextInputType.text,
              ),

              const SizedBox(height: 20),

              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.emailAddress,
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
                child: Container(
                  child: const Text('Log in'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    color: blueColor,
                  )
                ),
              ),
              const SizedBox(height: 12,),
              Flexible(child: Container(),flex:1),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child:  Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 50,
                      horizontal: 15
                    )
                  ),
                   GestureDetector(
                    onTap:(){},
                     child: Container(
                      child:  Text("Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                      padding: const EdgeInsets.symmetric(
                        vertical: 33,
                      )
                                       ),
                   )
                ],
              )
            ],
            
          ),
        ),
      ),
    );
  }
}
