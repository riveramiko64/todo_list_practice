import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'database.dart';
import 'alertdialog.dart';
import 'todotile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  DateTime? _selectedDate;
  bool isTextFieldEmpty = false;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask(String taskName, DateTime selectedDate, TimeOfDay selectedTime) {
    setState(() {
      db.addNewTask(taskName, false, selectedDate, selectedTime);
      _controller.clear();
      _selectedDate = null;
      _selectedTime = null;
    });
    Navigator.of(context).pop(); // Close the dialog
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
          onDateSelected: (date) {
            setState(() {
              _selectedDate = date;
            });
          },
          onTimeSelected: (time) {
            setState(() {
              _selectedTime = time;
            });
          },
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          'To-Do List ✔',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            dueDate: db.toDoList[index][2],
            dueTime: db.toDoList[index][3],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
