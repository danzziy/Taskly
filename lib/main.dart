import 'package:flutter/material.dart';
import 'package:myapp/pages/auth.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/home_lists.dart';
import 'package:myapp/pages/login.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/services/task_list.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:url_launcher/url_launcher.dart';

final pb = PocketBase('https://8h2tfzlz-8090.use.devtunnels.ms/');

void main() {
  runApp(MyApp(authService: AuthService(pb: pb), taskListService: TaskListService(pb: pb),));
}

class MyApp extends StatelessWidget {
  final AuthService authService; 
  final TaskListService taskListService; 

  const MyApp({super.key, required this.authService, required this.taskListService});
  // This widget is the root of your appliRcation.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: AuthPage(authService: authService, taskListService: taskListService),
      routes: {
        '/homelist': (context) => HomeLists(taskListService: taskListService),
        '/homepage': (context) => HomePage(),
      },
    );
  }
}
