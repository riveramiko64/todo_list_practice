// database.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

class ToDoDataBase {
  List<List<dynamic>> toDoList = []; // Each task is a list with [taskName, taskCompleted, dueDate, dueTime]

  final _myBox = Hive.box('mybox');

  // Run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false, DateTime.now(), TimeOfDay.now()],
    ];
    updateDataBase(); // Update database with initial data
  }

  // Load the data from database
  void loadData() {
    List<dynamic>? data = _myBox.get("TODOLIST");
    if (data != null) {
      toDoList = List<List<dynamic>>.from(data);
    }
  }

  // Update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }

  // Add a method to delete a task
  void deleteTask(int index) {
    toDoList.removeAt(index);
    updateDataBase(); // Update database after deleting the task
  }

  // Add a method to add a new task
  void addNewTask(String taskName, bool taskCompleted, DateTime? dueDate, TimeOfDay? dueTime) {
    toDoList.add([taskName, taskCompleted, dueDate, dueTime]);
    updateDataBase(); // Update database after adding the task
  }
}