import 'package:flutter/material.dart';
import 'floatingbutton.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final Function(String, DateTime, TimeOfDay) onSave;
  final VoidCallback onCancel;
  final Function(DateTime)? onDateSelected;
  final Function(TimeOfDay)? onTimeSelected;

  DialogBox({
    Key? key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    this.onDateSelected,
    this.onTimeSelected,
  }) : super(key: key);

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  bool isTextFieldEmpty = true;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = null;
    _selectedTime = null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: widget.controller,
              onChanged: (value) {
                setState(() {
                  isTextFieldEmpty = value.isEmpty;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new To-Do Task",
              ),
            ),
            SizedBox(height: 10,),
            Visibility(
              visible: !isTextFieldEmpty,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Due date and time :', style: TextStyle(fontSize: 15,),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Date not set',
                          border: UnderlineInputBorder(),
                        ),
                        controller: TextEditingController(
                          text: _selectedDate == null ? '' : _selectedDate.toString().substring(0, 10),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => _selectTime(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Time not set',
                          border: UnderlineInputBorder(),
                        ),
                        controller: TextEditingController(
                          text: _selectedTime == null ? '' : _selectedTime!.format(context),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
            // Show the message if all input fields are empty and Save button is pressed
            if (isTextFieldEmpty || _selectedDate == null || _selectedTime == null)
              Text(
                "Please enter all input fields before saving.",
                style: TextStyle(color: Colors.red,),textAlign: TextAlign.center,
              ),
            // save and cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  text: "Save",
                  onPressed: !isTextFieldEmpty && _selectedDate != null && _selectedTime != null
                      ? () {
                    final taskName = widget.controller.text;
                    widget.onSave(taskName, _selectedDate!, _selectedTime!);
                    // Reset task name, selected date, and selected time to null
                    widget.controller.clear();
                    setState(() {
                      _selectedDate = null;
                      _selectedTime = null;
                    });
                    // Close the dialog
                  }
                      : null, // Disable the button if any field is empty
                ),
                const SizedBox(width: 8),
                MyButton(
                  text: "Cancel",
                  onPressed: () {
                    // Reset task name, selected date, and selected time to null
                    widget.controller.clear();
                    setState(() {
                      _selectedDate = null;
                      _selectedTime = null;
                    });
                    // Close the dialog
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
