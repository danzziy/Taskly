import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/components/bottom_nav_bar.dart';
import 'package:myapp/services/lists.dart';

// TODO: I need a way to cache a user's lists so loading from DB isn't so painful.

class HomeLists extends StatelessWidget {
  final TaskListService taskListService;

  HomeLists ({super.key, required this.taskListService});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TaskLists(taskListService: taskListService),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(taskListService: taskListService),
    );
  }
}

class TaskLists extends StatefulWidget {
  final TaskListService taskListService;

  TaskLists({required this.taskListService});

  @override
  _TaskListsState createState() => _TaskListsState();
}

class _TaskListsState extends State<TaskLists> {
  @override
  Widget build(BuildContext context) {
    dynamic taskLists;
    return FutureBuilder(
      future: widget.taskListService.subscribeToTaskLists((event) {
          setState(() {
            print("WE HAVE UPDATED GUYS ");
          });
        }
      ),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        taskLists = jsonDecode(snapshot.data.toString());
        
        return ListView.separated(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              // height: 75,
              // width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                 boxShadow:[
                  BoxShadow(
                    color: Color(0xff1d1617).withOpacity(0.20),
                    blurRadius: 40,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // TODO: I think the '!' is going to cause an issue down the line.
                    // TODO: Use 2 Columns instead of 2 rows for alignment of widgets.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              taskLists![index]['name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "${taskLists![index]['completed_tasks']}/${taskLists![index]['tasks']}",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(taskLists![index]['created']),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }, 
          separatorBuilder: (context, index) => SizedBox(height: 10,),
          itemCount: taskLists!.length,
        );
      }
    );
  }
}
