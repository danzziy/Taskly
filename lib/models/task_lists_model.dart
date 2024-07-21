import 'package:flutter/material.dart';

class TaskListModel {
  String id;
  String name;
  String created;
  String owner;
  List <String> viewers;


  TaskListModel({
    required this.id, 
    required this.name,
    required this.created, 
    required this.owner,
    required this.viewers
  });
}