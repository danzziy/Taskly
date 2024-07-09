import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/services/task_list.dart';
import 'package:pocketbase/pocketbase.dart';

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
            const Text("Private Lists....."),
            FutureBuilder(
              future: taskListService.viewLists(), 
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                final taskLists = snapshot.data;
                print(snapshot.data);
                print(taskLists);
                print(taskLists!.length);
                // return Row();
                return ListView.separated(
                  shrinkWrap: true,

                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Text("hi"),
                      ],
                    );
                  }, 
                  separatorBuilder: (context, index) => SizedBox(width: 20,),
                  itemCount: taskLists!.length,
                );
              }
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
