import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/models/category_model.dart';
import 'package:myapp/models/diet_models.dart';
import 'package:myapp/models/popular_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List <CategoryModel> categories = [];
  List <DietModel> diets = [];
  List <PopularDietsModel> popularDiets = [];

  void _getInitialInfo(){
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchField(),
          const SizedBox(height: 30),
          _getContainers(),
          const SizedBox(height: 30),
          _dietSection(),
          const SizedBox(height: 30),
          _popularDiets(),
          SizedBox(height: 30,)
        ],
      ),
    );
  }

  Column _popularDiets() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Popular',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            DietList(popularDiets: popularDiets),
          ],
        );
  }

  Column _dietSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Recommendation\nfor Diet',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 225,
              child: ListView.separated(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                itemCount: diets.length,
                separatorBuilder: (context, index) { return SizedBox(width: 20,); },
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: diets[index].boxColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(diets[index].iconPath),
                      ), Column(
                        children: [
                          Text(
                            diets[index].name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            diets[index].level + '|' + diets[index].duration + '|' + diets[index].calorie,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ]
                      ),
                      Container(
                        height: 45,
                        width: 130,
                        child: Center(
                          child: Text(
                            'View',
                            style: TextStyle(
                              color: diets[index].viewIsSelected ? Colors.white : Color(0xffC58BF2),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              diets[index].viewIsSelected ? (Colors.blue[200])! : Colors.transparent,
                              diets[index].viewIsSelected ? (Colors.purple[200])! : Colors.transparent,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(50)
                        ),
                      )
                    ],
                  )
                ), 
              ),
            )
          ],
        );
  }

  Column _getContainers() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Category',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 120,
              child: ListView.separated(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                separatorBuilder: (context, index) => SizedBox(width: 20,),
                itemBuilder: (context, index){
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: categories[index].boxColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(categories[index].iconPath),
                          )
                        ),
                        Text(
                          categories[index].name,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        )
                      ],
                    )
                  );
                },
              )
            ),
          ],
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
                        child: SvgPicture.asset('assets/icons/Filter.svg'),
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

  AppBar appBar() {
    return AppBar(
      title: const Text(
        "hello",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
            ),
          ),
        ),
      ],
    );
  }
}

class DietList extends StatelessWidget {
  final List<PopularDietsModel> popularDiets;

  DietList({required this.popularDiets});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: popularDiets.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) => SizedBox(height: 25,),
      padding: EdgeInsets.only(
        right: 20,
        left: 20,
      ),
      itemBuilder: (context, index) {
        return DietItem(index: index, popularDiet: popularDiets[index]);
      },
    );
  }
}


class DietItem extends StatefulWidget {
  final int index;
  final PopularDietsModel popularDiet;

  DietItem({required this.index, required this.popularDiet});

  @override
  _DietItemState createState() => _DietItemState();
}

class _DietItemState extends State<DietItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: widget.popularDiet.boxIsSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 10),
            blurRadius: 40,
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SvgPicture.asset(
              widget.popularDiet.iconPath,
              width: 60,
              height: 65,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.popularDiet.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${widget.popularDiet.level} | ${widget.popularDiet.duration} | ${widget.popularDiet.calorie}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.popularDiet.boxIsSelected = !widget.popularDiet.boxIsSelected;
              });
            },
            child: SvgPicture.asset(
              'assets/icons/button.svg',
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
    );
  }
}


