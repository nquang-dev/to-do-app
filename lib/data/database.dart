import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {

  List toDoList = [];

  //reference our box
  final _myBox = Hive.box('mybox');

  //run this method if this is the first time opeing app
  void createInitalData(){
    toDoList = [
      ["test 1", false],
      ["test 2", false],
    ];
  }

  //load the data form db
  void loadData(){
    toDoList = _myBox.get("TODOLIST");
}

  //update the database
  void updateDatabase(){
    _myBox.put("TODOLIST", toDoList);

  }
}