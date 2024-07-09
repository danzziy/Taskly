import "package:flutter/material.dart";

class CategoryModel{
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });

  static List <CategoryModel> getCategories(){
    List <CategoryModel> categories = [];

    categories.add(
      CategoryModel(
        name: 'Salad', 
        iconPath: 'assets/food_tutorial/plate.svg', 
        boxColor: (Colors.purple[100])!,
      )
    );
    categories.add(
      CategoryModel(
        name: 'Cake', 
        iconPath: 'assets/food_tutorial/pancakes.svg', 
        boxColor: (Colors.red[100])!,
      )
    );
    categories.add(
      CategoryModel(
        name: 'Pie', 
        iconPath: 'assets/food_tutorial/pie.svg', 
        boxColor: (Colors.deepOrange[100])!,
      )
    );
    categories.add(
      CategoryModel(
        name: 'Pie', 
        iconPath: 'assets/food_tutorial/orange-snacks.svg', 
        boxColor: (Colors.green[100])!,
      )
    );
    return categories;
  }
}