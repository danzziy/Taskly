import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/components/bottom_nav_bar.dart';
import 'package:myapp/services/lists.dart';
import 'package:myapp/services/userSearch.dart';
import 'package:myapp/services/lists.dart';
import 'package:pocketbase/pocketbase.dart';


// TODO: Fix bottom overflow when keyboard is up.

class Search extends StatelessWidget {
  final UserSearchService userSearchService;
  final TaskListService taskListService;

  Search({super.key, required this.userSearchService, required this.taskListService});

 @override
  Widget build(BuildContext context) {
    TextEditingController userSearchController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            _searchField(userSearchController),
            SizedBox(height: 20,),
            UserList(userSearchService: userSearchService, userSearchController: userSearchController)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(taskListService: taskListService),
    );
  }

  Container _searchField(TextEditingController userSearchController) {
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
        controller: userSearchController,
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
            child: SvgPicture.asset('assets/icons/Search.svg'),
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



class UserList extends StatefulWidget {
  final UserSearchService userSearchService;
  final TextEditingController userSearchController;
  UserList({required this.userSearchService, required this.userSearchController});

  @override
  _UserListState createState() => _UserListState();

}

class _UserListState extends State<UserList> {
  late Future<ResultList<dynamic>> _futureUserList;
  dynamic userList;

  @override
  void initState() {
    super.initState();
    _futureUserList = widget.userSearchService.listUsers('');
    widget.userSearchController.addListener(_onSearchChanged);
  }
  
  @override
  void didUpdateWidget(UserList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userSearchController != widget.userSearchController) {
      oldWidget.userSearchController.removeListener(_onSearchChanged);
      widget.userSearchController.addListener(_onSearchChanged);
    }
  }

  @override
  void dispose() {
    widget.userSearchController.removeListener(_onSearchChanged);
    super.dispose();
  }
  
  void _onSearchChanged() {
    print("upda");
    setState(() {
      print('pls');
      _futureUserList =  widget.userSearchService.listUsers(widget.userSearchController.text);
      // print(result.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureUserList,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        print(snapshot.toString());
        userList = jsonDecode(snapshot.data.toString())['items'];
        print(userList);
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // TODO: I think the '!' is going to cause an issue down the line.
                    // TODO: Use 2 Columns instead of 2 rows for alignment of widgets.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          userList![index]['username'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }, 
          separatorBuilder: (context, index) => SizedBox(height: 10,),
          itemCount: userList!.length,
        );
      }
    );
  }
}