
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/constants/colors.dart';
import 'package:to_do_list/data/dataBase.dart';
import 'model/todo_item.dart';

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  final _myBox = Hive.box('myBox');
  DataBase db = DataBase();

  final _controller = TextEditingController();
  void checkBoxValue(int index, bool? value) {
    setState(() {
      db.list[index][1] = !db.list[index][1];
      
    });
    db.updateData();
  }

  void addtoDo() {
    setState(() {
      db.list.add([_controller.text, false]);
    });
  }

  void deleteTask(int index) {
    setState(() {
      db.list.removeAt(index);
    });
  }

  @override
  void initState() {
    if (_myBox.get('myBox') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      appBar: BuildAppBar(),
      ///////////////////
      body: Container(
        // padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SearchBox(),
            Container(
              child: Text(
                "All To Dos",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: db.list.length,
                itemBuilder: (context, index) {
                  return ToDo(
                    taskName: db.list[index][0],
                    taskCompleted: db.list[index][1],
                    onChanged: (value) => checkBoxValue(index, value),
                    deleteFunction: (context) => deleteTask(index),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 20,
                      height: 40,
                      margin: EdgeInsets.only(right: 10, left: 20, bottom: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: White,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Enter your task",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: ElevatedButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        addtoDo();
                        db.updateData();
                        _controller.clear();
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(50, 50), elevation: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

/////////////////////////////
  ///AppBar
  AppBar BuildAppBar() {
    return AppBar(
      backgroundColor: Grey,
      elevation: 0,

      ///App bar color
      title: Row(
        children: [
          Container(
            //padding: EdgeInsets.all(10),
            child: Icon(
              ///to set menu icon///
              Icons.menu,
              color: Black,
              size: 25,
            ),
          ),
          ////////////////////////
          Container(
            ///container of text///////
            padding: EdgeInsets.symmetric(horizontal: 55),
            child: Text("Welcome to ToDo List App",
                style: TextStyle(
                  color: Black,
                  fontSize: 20,
                )),
          ),
        ],
      ),
    );
  }

  /////////////Search Box
  Widget SearchBox() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            width: 410,
            height: 40,
            decoration: BoxDecoration(
              color: White,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "search",
                prefixIcon: Icon(Icons.search, color: Black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
