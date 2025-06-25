import 'package:flutter/material.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();


  @override
  void initState() {
    // if this is the first time opeing the app, then create defalut data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitalData();
    }
    else {
      db.loadData();
    }
    super.initState();
  }

  final _contronller = TextEditingController();


  //checkbox was tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  //save a new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_contronller.text, false]);
      _contronller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // create a new task
  void createNewTask(){
    showDialog(context: context, builder: (context) {
      return DialogBox(
        controller: _contronller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop() ,
      );
    },);
    db.updateDatabase();
  }
  
//delete task
  void deleteTask (int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO APP'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        createNewTask();
      },
      child: Icon(Icons.add),),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(taskName: db.toDoList[index][0], 
          taskCompleted: db.toDoList[index][1], 
          onChanged: (value) => checkBoxChanged(value, index),
          deleteFunction: (context) => deleteTask(index),);
          
      },)
    );
  }
}