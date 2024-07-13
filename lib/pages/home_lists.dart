import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/services/task_list.dart';
import 'package:pocketbase/pocketbase.dart';

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
      bottomNavigationBar: _BottomNavigationBar(),
    );
  }

  BottomNavigationBar _BottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/home-bold.svg'),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/search-outline.svg'),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/add-square-outline.svg'),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/video-play-outline.svg'),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/icons/google.png')),
              shape: BoxShape.circle,
            ),
          ),
          label: '',
        ),
      ],
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
              height: 75,
              width: 50,
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO: I think the '!' is going to cause an issue down the line.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              taskLists![index]['name']+ "jhgjhjhjdsfdhbgjg",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          textAlign: TextAlign.end,
                          "${taskLists![index]['completed_tasks']}/${taskLists![index]['tasks']}",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(taskLists![index]['created'])
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
