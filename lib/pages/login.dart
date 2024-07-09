import 'package:flutter/material.dart';
import 'package:myapp/components/buttom.dart';
import 'package:myapp/components/input_field.dart';
import 'package:myapp/components/square_tile.dart';
import 'package:myapp/services/auth.dart';

class Login extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService;

  Login ({super.key, required this.authService});

  void signUserWithEmail(email, password){
    authService.loginWithEmail(email, password);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 150),
              const Text("Welcome to Taskly"),
              InputField(
                hintText: 'Email', 
                controller: emailController, 
                obscureText: false,
              ),
              const SizedBox(height: 20,),
              InputField(hintText: 'Password', 
                controller: passwordController, 
                obscureText: true,
              ),
              const SizedBox(height: 5,),
              const Text("Forgot Password?"),
              const SizedBox(height: 30,),
              MyButton(onTap: () async {
                // await authService.createUser("stupid@hotmail.com", "stupid@123", "stupid@123");
                signUserWithEmail(emailController.text, passwordController.text);
              }),
              const SizedBox(height: 5,),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Text("or continue with"),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),

              // google + apple sign in buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(imagePath: 'assets/icons/google.png'),
                  SizedBox(width: 25),
                  // apple button
                  SquareTile(imagePath: 'assets/icons/apple.png')
                ],
              ),
              const SizedBox(height: 30),
              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}