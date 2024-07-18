import 'package:flutter/material.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/home_lists.dart';
import 'package:myapp/pages/login.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/services/lists.dart';
import 'package:pocketbase/pocketbase.dart';

class AuthPage extends StatelessWidget {
  final AuthService authService; 
  final TaskListService taskListService;
  const AuthPage ({
    super.key, 
    required this.authService, 
    required this.taskListService
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AuthStoreEvent> (
        stream: authService.authStateChanged(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            // return HomePage();
            return HomeLists(taskListService: taskListService);
          }
          else {
            return Login(authService: authService);
          }
          // return HomeLists(taskListService: taskListService);
        },
      ),
    );
  }
  
}