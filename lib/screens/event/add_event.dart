
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  AddEventPage({Key key, this.title}) : super(key: key);

  final String title;
  TextEditingController controllerEventName = new TextEditingController();
  TextEditingController controllerNumMaxPeople = new TextEditingController();
  TextEditingController controllerDate = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
          key: widget.formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                maxLines: 1,
                style: TextStyle(fontSize: 17),
                controller: widget.controllerEventName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.sticky_note_2,
                    color: Colors.grey,
                  ),
                  hintText: 'Task Name',
                ),
              ),
              SizedBox(height: 20),
              dateField(widget.controllerDate),
              SizedBox(height: 20)
            ],
          ),
        ));
  }

  Widget dateField(TextEditingController controllerDate) {
    return Column(children: <Widget>[
      DateTimeField(
        controller: controllerDate,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.access_time,
            color: Colors.grey,
          ),
          hintText: 'Event Date & Time',
        ),
        format: DateFormat("yyyy-MM-dd HH:mm:ss"),
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


