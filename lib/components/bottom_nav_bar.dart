import 'package:flutter/material.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/services/task_list.dart';
import 'package:myapp/components/input_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatefulWidget {
  final TaskListService taskListService;
  BottomNavBar({required this.taskListService});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        setState(() {
        });
        switch (index) {
          case 0:
            //  Navigate to Home
            Navigator.pushNamed(context, '/homelists');
            break;
          case 1:
            // Navigator.pushNamed(context, '/homepage');
            break;
          case 2:
            showDialog (
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  // title: Text('New List'),
                  // shape: BoxShape.circle,
                  content: SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InputField(
                          hintText: 'Name', 
                          obscureText: false,
                          controller: textController,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        widget.taskListService.createTaskList(textController.text);
                      }, 
                      child: Text('Add List'),
                    )
                  ],
                );
              }
            );
            break;
          case 3:
            //  Navigate to Video Play
            break;
          case 4:
            // Navigate to Profile or any other action
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          label: '',
          icon: SvgPicture.asset('assets/icons/home-outline.svg'),
          activeIcon: SvgPicture.asset('assets/icons/home-bold.svg'),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: SvgPicture.asset('assets/icons/search-outline.svg'),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: SvgPicture.asset('assets/icons/add-square-outline.svg'),
          activeIcon: SvgPicture.asset('assets/icons/add-square-bold.svg'),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: SvgPicture.asset('assets/icons/video-play-outline.svg'),
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
