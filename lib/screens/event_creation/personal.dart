import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Personal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PersonalState();
  }
}

class PersonalState extends State<Personal> {
  static final formKey = GlobalKey<FormState>();
  static TextEditingController controllerEventName = new TextEditingController();
  static TextEditingController controllerLastName = new TextEditingController();
  static TextEditingController controllerEventDate = new TextEditingController();
  static TextEditingController controllerGender = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                maxLines: 1,
                controller: controllerEventName,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.paste,
                    color: Colors.grey,
                  ),
                  hintText: 'Event Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Event Name is Required";
                  }
                },
              ),
              SizedBox(height: 20),
              BasicDateTimeField(),
              SizedBox(height: 20),
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
            Icons.paste,
            color: Colors.grey,
          ),
          hintText: 'Event Date & Time',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
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
