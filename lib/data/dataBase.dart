import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  List list = [];

  ///reference a box
  final _myBox = Hive.box('myBox');
//run this method if it first time opening this app
  void createInitialData() {
    list = [
      ["task5", false]
    ];
  }

//load the box
  void loadData() {
    list = _myBox.get('myBox');
  }

  void updateData() {
    _myBox.put('myBox', list);
  }
}
