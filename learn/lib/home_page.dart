import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Slidable(
          startActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(onPressed: (context) {
              //
            },),
            Icon(Icons.phone)
          ]),
          child: Container(
            color: Colors.grey[300],
            child: ListTile(
              title: Text('Nhat Quang'),
              subtitle: Text('012456789'),
              leading: Icon(Icons.person, size: 40,),
            ),
          ),
        ),
      ),
    );
  }
}