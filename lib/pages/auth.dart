import 'package:flutter/material.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/login.dart';
import 'package:myapp/services/auth.dart';
import 'package:pocketbase/pocketbase.dart';

class AuthPage extends StatelessWidget {
  final AuthService authService; 

  const AuthPage ({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AuthStoreEvent> (
        stream: authService.authStateChanged(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return HomePage();
          }
          else {
            return Login(authService: authService);
          }
        },
      ),
    );
  }
  
}