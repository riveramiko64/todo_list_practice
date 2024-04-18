import 'package:flutter/material.dart';


class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final DateTime? dueDate;
  final TimeOfDay? dueTime;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({super.key, 
    required this.taskName,
    required this.taskCompleted,
    required this.dueDate,
    required this.dueTime,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 4, // Blur radius
              offset: const Offset(0, 2), // Offset of the shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Checkbox
                Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                ),

                const SizedBox(width: 10,),

                // Task name
                Expanded(
                  child: Text(
                    taskName,
                    style: TextStyle(
                      fontSize: 20,
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),

                // Display date and time


                // Delete button (conditionally shown)
                Visibility(
                  visible: taskCompleted,
                  child: IconButton(
                    onPressed: () => deleteFunction!(context),
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            const Row(
              children: [
                SizedBox(height: 10,),
              ],
            ),
            const Row(
              children: [
                SizedBox(width: 40,),
                Text('Date and Time:'),
              ],
            ),

            if (dueDate != null && dueTime != null)


              Row(
                children: [
                  const SizedBox(width: 40,),
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 5),
                  Text('${dueDate!.day}/${dueDate!.month}/${dueDate!.year}'),
                  const SizedBox(width: 10),
                  const Icon(Icons.access_time),
                  const SizedBox(width: 5),
                  Text('${dueTime!.hour}:${dueTime!.minute}'),
                ],
              ),


          ],
        ),
      ),
    );
  }
}
