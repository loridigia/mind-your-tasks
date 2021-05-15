import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  AddTaskPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  static final _formKey = GlobalKey<FormState>();
  static TextEditingController controllerTaskName = new TextEditingController();
  static TextEditingController controllerPeople = new TextEditingController();
  static TextEditingController controllerDescription = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                maxLines: 1,
                style: TextStyle(fontSize: 17),
                controller: controllerTaskName,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.sticky_note_2,
                    color: Colors.grey,
                  ),
                  hintText: 'Task Name',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLines: 1,
                style: TextStyle(fontSize: 17),
                controller: controllerPeople,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.people_alt,
                    color: Colors.grey,
                  ),
                  hintText: 'Assigned to',
                ),
              ),
              SizedBox(height: 20),
              BasicDateTimeField(),
              SizedBox(height: 20),
              TextFormField(
                maxLines: 5,
                style: TextStyle(fontSize: 13),
                controller: controllerDescription,
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
              ),
            ],
          ),
        ));
  }

}

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.access_time,
            color: Colors.grey,
          ),
          hintText: 'Event Date & Time',
        ),
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
              TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}


