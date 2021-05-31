
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mind_your_tasks/models/Task.dart';
import 'package:select_form_field/select_form_field.dart';

class TaskDetails extends StatefulWidget {
  TaskDetails({Key key, this.task}) : super(key: key);

  Task task;

  TextEditingController controllerPeople = new TextEditingController();
  TextEditingController controllerStatus = new TextEditingController();


  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {

  final List<Map<String, dynamic>> _users = [
    {
      'value': "",
      'label': 'Not assigned',
      'textStyle': TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black),
    },
    {
      'value': 'TestUser',
      'label': 'TestUser',
      'textStyle': TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black),
    },
  ];
  
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'COMPLETED',
      'label': 'COMPLETED',
      'icon': Icon(Icons.check, color: Color.fromRGBO(67, 147, 31, 1.0)),
      'textStyle': TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black),
    },
    {
      'value': 'ACTIVE',
      'label': 'ACTIVE',
      'icon': Icon(Icons.replay, color: Color.fromRGBO(246, 197, 15, 0.8)),
      'textStyle': TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black),
    },
    {
      'value': 'PENDING',
      'label': 'PENDING',
      'enable': true,
      'icon': Icon(Icons.alarm, color: Color.fromRGBO(219, 20, 36, 1.0)),
      'textStyle': TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black),
    },
  ];

  Color _getColorFromStatus(Status status) {
    if (status == Status.COMPLETED) return Color.fromRGBO(67, 147, 31, 1.0);
    else if (status == Status.ACTIVE) return Color.fromRGBO(246, 197, 15, 1.0);
    else return Color.fromRGBO(219, 20, 36, 1.0);
  }

  getSelectUser() {
    widget.controllerPeople = new TextEditingController(text: widget.task.user != null ? widget.task.user.username : "");
    return SelectFormField(
      textAlign: TextAlign.center,
      controller: widget.controllerPeople,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.arrow_drop_down),
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none
      ),
      items: _users,
      style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w400),
      onChanged: (val) => print(val),
      onSaved: (val) => print(val),
    );
  }

  getSelectStatus() {
    widget.controllerStatus = new TextEditingController(text: widget.task.status.toString().substring(7));
    return SelectFormField(
      textAlign: TextAlign.center,
      controller: widget.controllerStatus,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.arrow_drop_down),
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none
      ),
      items: _items,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w400),
      onChanged: (val) => print(val),
      onSaved: (val) => print(val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.only(left: 2, right: 2, top: 15, bottom: 15),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.sticky_note_2, size: 25, color: Colors.grey,)
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: <Widget>[
                        Text(
                            widget.task.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(212, 212, 212, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.access_time, size: 25, color: Colors.grey,)
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: <Widget>[
                        Text(
                            widget.task.date != null ?
                            widget.task.date.day.toString()+"-"+widget.task.date.month.toString()+"-"+widget.task.date.year.toString()+" "+ widget.task.date.hour.toString()+":"+widget.task.date.minute.toString() : "No date",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(212, 212, 212, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.assignment_ind, size: 25, color: Colors.grey)
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: <Widget>[
                        getSelectUser()
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(212, 212, 212, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.pending_actions_rounded, size: 25, color: Colors.grey)
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: <Widget>[
                        getSelectStatus(),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 15),
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(212, 212, 212, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text(
                            widget.task.description != ""  ? widget.task.description : "No description",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}


