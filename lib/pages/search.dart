import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/components/bottom_nav_bar.dart';
import 'package:myapp/services/lists.dart';
import 'package:myapp/services/userSearch.dart';
import 'package:myapp/services/lists.dart';


// TODO: Fix bottom overflow when keyboard is up.

class Search extends StatelessWidget {
  final UserSearchService userSearchService;
  final TaskListService taskListService;

  Search({super.key, required this.userSearchService, required this.taskListService});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            _searchField(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(taskListService: taskListService),
    );
  }

  Container _searchField() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        boxShadow:[
            BoxShadow(
            color: Color(0xff1d1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(15),
          hintText: "Search Pancake",
          hintStyle: TextStyle(
            color: Colors.grey
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset('assets/icon/Search.svg'),
          ),
          suffixIcon: Container(
            width: 100,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  VerticalDivider(
                    color: Color(0x0),
                    indent: 10,
                    endIndent: 10,
                    thickness: 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset('assets/food_tutorial/Filter.svg'),
                  ),
                ],
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          )
        ),
      ),
    );
  }
}
