import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mind_your_tasks/models/Event.dart';
import 'package:mind_your_tasks/models/Task.dart';
import 'package:mind_your_tasks/screens/event/event_home_page.dart';
import 'package:mind_your_tasks/screens/task/task_details.dart';
import 'package:mind_your_tasks/screens/task/tasks_utils.dart';
import 'package:mind_your_tasks/theme/colors/light_colors.dart';
import 'package:mind_your_tasks/widgets/main_drawer.dart';
import 'package:mind_your_tasks/widgets/task_container.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../storage_utils.dart';
import '../home_page.dart';

class SearchTaskPage extends StatefulWidget {
  SearchTaskPage({Key key, this.event, this.tasks, this.title, this.username}) : super(key: key);

  Event event;
  List<Task> tasks;
  final String title;
  final String username;

  final formKey = GlobalKey<FormState>();

  TextEditingController controllerPeople = new TextEditingController();

  @override
  _SearchTaskPageState createState() => _SearchTaskPageState();
}

class _SearchTaskPageState extends State<SearchTaskPage> {
  @override
  Widget build(BuildContext context) {
    widget.controllerPeople = new TextEditingController(text: widget.username != null ? widget.username : "");
    List<Task> filteredTask = widget.tasks;
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 243, 248, 1.0),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          title: Text(
              "Search " + widget.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500)
          ),
          backgroundColor: LightColors.kBlue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              if (widget.event != null) {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventHomePage(event: widget.event)),
                )
              }
              else {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage()),
                )
              }
            }
          ),
          elevation: 0,
        ),
      ),
      drawer: MainDrawer(),
      body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  color: LightColors.kBlue,
                  child: Form(
                    key: widget.formKey,
                    child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: TextFormField(
                              style: TextStyle(fontSize: 15, color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.sticky_note_2,
                                  color: Colors.white,
                                ),
                                hintText: 'Task Name',
                              ),
                              onChanged: (string) {
                                setState(() {
                                  filteredTask = widget.tasks
                                      .where((u) => (u.name
                                      .toLowerCase()
                                      .contains(string.toLowerCase())))
                                      .toList();
                                });
                                debugPrint(filteredTask.length.toString());
                              },
                            ),
                          ),
                          Expanded(
                            flex: 50,
                            child: TextFormField(
                              readOnly: widget.username != null,
                              controller: widget.controllerPeople,
                              style: TextStyle(fontSize: 15, color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.people_alt,
                                  color: Colors.white,
                                ),
                                hintText: 'People',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: TextFormField(
                              maxLines: 1,
                              style: TextStyle(fontSize: 15, color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                ),
                                hintText: 'Date',
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 50,
                            child: TextFormField(
                              maxLines: 1,
                              style: TextStyle(fontSize: 15, color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.pending_actions_rounded,
                                  color: Colors.white,
                                ),
                                hintText: 'Status',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ),
              Flexible(
                child: GridView.builder(
                  itemCount: filteredTask.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0
                  ),
                  itemBuilder: (BuildContext context, int index){
                    Task task = filteredTask[index];
                    return  GestureDetector(
                        onTap: () => _taskDetails(context, task),
                        child: TaskContainer(
                            color: TaskUtils.getColorFromStatus(filteredTask[index].status),
                            taskName: task.name,
                            personName: task.user != null ? task.user.username : "Not assigned",
                            date: task.date != null ? task.date.year.toString()+"-"+task.date.month.toString()+"-"+task.date.day.toString()+" "+task.date.hour.toString()+":"+task.date.minute.toString() : "No date",
                            desc: task.description),
                      );
                  },
                ),
              ),
            ],
          ),
      ),
    );
  }

  removeTaskFromList(Task task) {
    List<Task> newList = [];
    widget.tasks.forEach((element) {
      if (element.UUID != task.UUID) newList.add(element);
    });
    widget.tasks = newList;
  }

  updateTaskFromList(Task task) {
    List<Task> newList = [];
    widget.tasks.forEach((element) {
      if (element.UUID == task.UUID) newList.add(task);
      else newList.add(element);
    });
  }

  _taskDeleteContent() {
    return Container(
      child: Column(
        children: [
          Text(
            "Are you sure you want delete this task?",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  deleteTask(Task task, Event event) async {
    debugPrint(json.encode(event));
    List<Task> tasks = event.tasks;
    List<Task> new_tasks = [];
    tasks.forEach((element) {
      if (element.UUID != task.UUID) new_tasks.add(element);
    });
    event.tasks = new_tasks;
    bool updated = await StorageUtils.updateEvent(event);
    removeTaskFromList(task);
  }

  _taskDelete(context, Task task, Event event) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
      animationDuration: Duration(milliseconds: 200),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Colors.white,
        ),
      ),
      titleStyle: TextStyle(
          color: Colors.red,
          fontSize: 22,
          fontWeight: FontWeight.w800
      ),
    );

    Alert(
        context: context,
        style: alertStyle,
        type: AlertType.none,
        title: "DELETE TASK",
        content: _taskDeleteContent(),
        buttons: [
          DialogButton(
            onPressed: () async => {
              Navigator.pop(context),
              _taskDetails(context, task)
            },
            color: Colors.grey,
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            onPressed: () => {
              Navigator.pop(context),
              deleteTask(task, event),
              setState(() {}),
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                  SnackBar(
                    content:
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              "Task deleted correctly",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800
                              )
                          )
                        ]
                    ),
                    backgroundColor: Colors.green,
                  )
              ),
            },
            color: Colors.red,
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }


  _taskDetails(context, Task task) async {
    var alertStyle = TaskUtils.getAlertStyle(task.status, true, false);
    TaskDetails taskDetails = TaskDetails(task: task);
    Event event = await StorageUtils.getEventByTask(task);
    debugPrint(event.name);

    Alert(
        context: context,
        style: alertStyle,
        type: AlertType.none,
        title: task.status.toString().substring(7) +" TASK",
        content: taskDetails,
        buttons: [
          DialogButton(
            onPressed: () => {
              Navigator.pop(context),
              _taskDelete(context, task, event)
            },
            color: Colors.red,
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            onPressed: () async => {
              task.status = TaskUtils.convertStatus(taskDetails.controllerStatus.text),
              task.user = taskDetails.controllerPeople.text != "" ?
              await StorageUtils.getUser(taskDetails.controllerPeople.text) : null,
              TaskUtils.updateTaskInEvent(task, event),
              await StorageUtils.updateEvent(event),
              updateTaskFromList(task),
              Navigator.pop(context),
              setState(() {}),
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                  SnackBar(
                    content:
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              "Task correctly modified",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800
                              )
                          )
                        ]
                    ),
                    backgroundColor: Colors.green,
                  )
              ),
            },
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }


}

