import 'dart:convert';

import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mind_your_tasks/models/Event.dart';
import 'package:mind_your_tasks/models/Task.dart';
import 'package:mind_your_tasks/models/User.dart';
import 'package:mind_your_tasks/screens/home_page.dart';
import 'package:mind_your_tasks/screens/task/add_task.dart';
import 'package:mind_your_tasks/screens/task/search_task_page.dart';
import 'package:mind_your_tasks/screens/task/task_details.dart';
import 'package:mind_your_tasks/screens/task/tasks_utils.dart';
import 'package:mind_your_tasks/theme/colors/light_colors.dart';
import 'package:mind_your_tasks/widgets/main_drawer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../storage_utils.dart';
import '../../widgets/task_container.dart';


class EventHomePage extends StatefulWidget {
  EventHomePage({Key key, this.event}) : super(key: key);

  Event event;

  @override
  _EventHomePageState createState() => _EventHomePageState();

  List<Task> getTasks(Status status) {
    List<Task> tasks = [];
    event.tasks.forEach((task) {
      if (task.status == status) tasks.add(task);
    });
    return tasks;
  }
}


class _EventHomePageState extends State<EventHomePage> {

  @override
  Widget build(BuildContext context) {
    double percentage = 50/100;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //backgroundColor: Color.fromRGBO(242, 243, 248, 1.0),
      backgroundColor: Color.fromRGBO(242, 243, 248, 1.0),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          backgroundColor: Color.fromRGBO(242, 243, 248, 1.0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage()),
            ),
          ),
          elevation: 0,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0, top: 10),
                child: GestureDetector(
                  onTap: () {_onAddPeople(context);},
                  child: Icon(
                      Icons.person_add,
                      color: Colors.black,
                  ),
                )
            ),
          ],
        ),
      ),
      drawer: MainDrawer(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 10),
                  child: Text(
                    widget.event.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight:
                        FontWeight.w700,
                        fontSize: 20,
                        color: Colors.black
                    ),
                  ),
                  )
                ]
            ),
            Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 280,
                    width: width,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 60,
                              child:Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 45,
                                          width: 2,
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent.withOpacity(0.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(left: 4, bottom: 2),
                                                child: Text(
                                                  'Partecipants',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    letterSpacing: -0.1,
                                                    color: Colors.blueAccent,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 23,
                                                    height: 23,
                                                    child: Icon(
                                                      Icons.people_alt,
                                                      color: Colors.blueAccent,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 4, bottom: 3),
                                                    child: Text(
                                                      widget.event.users.length.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 16,
                                                          color: Colors.blueAccent
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 45,
                                          width: 2,
                                          decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(0.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(left: 4, bottom: 2),
                                                child: Text(
                                                  'Date',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    letterSpacing: -0.1,
                                                    color: Color.fromRGBO(67, 147, 31, 0.8),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 23,
                                                    height: 23,
                                                    child: Icon(
                                                      Icons.access_time,
                                                      color: Color.fromRGBO(67, 147, 31, 0.8),
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(left: 4, bottom: 3),
                                                    child: Text(
                                                      widget.event.date.day.toString()+"-"+widget.event.date.month.toString()+"-"+widget.event.date.year.toString()+" "+ widget.event.date.hour.toString()+":"+widget.event.date.minute.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(67, 147, 31, 0.8)
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 40,
                              child:Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircularPercentIndicator(
                                      radius: 120.0,
                                      lineWidth: 10.0,
                                      animation: true,
                                      percent: percentage,
                                      center: Text(
                                        "50%",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      backgroundColor: Colors.grey[100],
                                      circularStrokeCap: CircularStrokeCap.round,
                                      progressColor: Colors.blueAccent.withOpacity(0.8),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 18, bottom: 8),
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(212, 212, 212, 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 18, bottom: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Completed',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.2,
                                            color: Colors.grey.withOpacity(0.7),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: LinearPercentIndicator(
                                            animation: true,
                                            percent: widget.getTasks(Status.COMPLETED).length / widget.event.tasks.length,
                                            lineHeight: 5,
                                            width: 90,
                                            linearStrokeCap: LinearStrokeCap.roundAll,
                                            backgroundColor: Colors.grey[100],
                                            progressColor: Color.fromRGBO(67, 147, 31, 1.0),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6),
                                          child: Text(
                                            widget.getTasks(Status.COMPLETED).length.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.grey.withOpacity(0.7),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Active',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.2,
                                            color: Colors.grey.withOpacity(0.7),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: LinearPercentIndicator(
                                            animation: true,
                                            percent: widget.getTasks(Status.ACTIVE).length / widget.event.tasks.length,
                                            lineHeight: 5,
                                            width: 90,
                                            linearStrokeCap: LinearStrokeCap.roundAll,
                                            backgroundColor: Colors.grey[100],
                                            progressColor: Color.fromRGBO(246, 197, 15, 1.0),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6),
                                          child: Text(
                                            widget.getTasks(Status.ACTIVE).length.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.grey.withOpacity(0.7),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Pending',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.2,
                                            color: Colors.grey.withOpacity(0.7),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: LinearPercentIndicator(
                                            animation: true,
                                            percent: widget.getTasks(Status.PENDING).length / widget.event.tasks.length,
                                            lineHeight: 5,
                                            width: 90,
                                            linearStrokeCap: LinearStrokeCap.roundAll,
                                            backgroundColor: Colors.grey[100],
                                            progressColor: Color.fromRGBO(219, 20, 36, 1.0),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6),
                                          child: Text(
                                            widget.getTasks(Status.PENDING).length.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.grey.withOpacity(0.7),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          "Task list",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight:
                              FontWeight.w700,
                              fontSize: 20,
                              color: Colors.black
                          ),
                        ),
                    ]
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  width: width,
                  child: DefaultTabController(
                    length: 5,
                    child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(55.0),
                        child: AppBar(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        bottom: TabBar(
                          labelColor: Colors.black,
                          indicatorColor: Colors.blueAccent,
                          tabs: [
                            Tab(icon: Icon(Icons.check, size: 40, color: Color.fromRGBO(67, 147, 31, 1.0))),
                            Tab(icon: Icon(Icons.replay, size: 35, color: Color.fromRGBO(246, 197, 15, 1.0))),
                            Tab(icon: Icon(Icons.alarm, size: 35, color: Color.fromRGBO(219, 20, 36, 1.0))),
                            GestureDetector(
                              onTap: () => _onAddTask(context),
                              child: Icon(Icons.note_add, size: 30, color: Colors.black),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchTaskPage(tasks: widget.event.tasks,)),
                                  );
                                },
                                child: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.black)
                            )
                          ],
                        ),
                      ),
                      ),
                      body: TabBarView(
                        children: [
                          showTaskList(Color.fromRGBO(67, 147, 31, 1.0), widget.getTasks(Status.COMPLETED)),
                          showTaskList(Color.fromRGBO(246, 197, 15, 1.0), widget.getTasks(Status.ACTIVE)),
                          showTaskList(Color.fromRGBO(219, 20, 36, 1.0), widget.getTasks(Status.PENDING)),
                          Icon(Icons.directions_bike),
                          Icon(Icons.directions_bike)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ],
            ),
    ),
    );
  }


  _buildTasks(Color color, List<Task> tasks) {
    List<Widget> list = [];
    tasks.forEach((element) {
      list.add(
          GestureDetector(
            onTap: () => _taskDetails(context, element),
            child: TaskContainer(
                color: color,
                taskName: element.name,
                personName: element.user != null ? element.user.username : "Not assigned",
                date: element.date != null ? element.date.day.toString()+"-"+element.date.month.toString()+"-"+element.date.year.toString()+" "+element.date.hour.toString()+":"+element.date.minute.toString() : "No date",
                desc: element.description),
          )
      );
    });
    if (list.isEmpty) list.add(
      Padding(
        padding: const EdgeInsets.only(left: 75, top: 40),
        child: Text(
            "THERE ARE NO TASKS",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
                fontWeight: FontWeight.w500)
        ),
      )
    );
    return list;
  }

  showTaskList(Color color, List<Task> tasks) {
    return Container(
            padding: const EdgeInsets.only(top: 10, bottom: 65),
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _buildTasks(color, tasks),
            ),
          );
  }

  _taskDetails(context, Task task) {
    var alertStyle = TaskUtils.getAlertStyle(task.status);
    TaskDetails taskDetails = TaskDetails(task: task);

    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.none,
      title: task.status.toString().substring(7) +" TASK",
        content: taskDetails,
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.grey,
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            onPressed: () async => {
              task.status = TaskUtils.convertStatus(taskDetails.controllerStatus.text),
              task.user = taskDetails.controllerPeople.text != null ?
                          await StorageUtils.getUser(taskDetails.controllerPeople.text) : null,
              TaskUtils.updateTaskInEvent(task, widget.event),
              await StorageUtils.updateEvent(widget.event),
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
              "Apply",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }



  _onAddPeople(context) {
    // Reusable alert style
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromRight,
      isCloseButton: false,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
      animationDuration: Duration(milliseconds: 200),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Colors.white,
        ),
      ),
      titleStyle: TextStyle(
          color: Colors.blueAccent,
          fontSize: 22,
          fontWeight: FontWeight.w800
      ),
    );

    // Alert dialog using custom alert style
    Alert(
        context: context,
        style: alertStyle,
        type: AlertType.none,
        title: "Share invite link",
        content: inviteLink(),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "COPY TO CLIPBOARD",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ]).show();
  }

  inviteLink() {
    return Container(
      child: Column(
        children: [
          Text(
              "The link will be valid for 15 minutes",
              style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          TextFormField(
            maxLines: 1,
            enabled: false,
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.link,
                color: Colors.grey,
              ),
              hintText: 'http://mindyourtask.it/'+widget.event.UUID,
            ),
          ),
        ],
      ),
    );
  }


  _onAddTask(context) {
    // Reusable alert style
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: true,
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
          color: Colors.blueAccent,
          fontSize: 22,
          fontWeight: FontWeight.w800
      ),
    );

    // Alert dialog using custom alert style

    AddTaskPage taskPage = AddTaskPage();
    Alert(
        context: context,
        style: alertStyle,
        type: AlertType.none,
        title: "Create new task",
        content: taskPage,
        buttons: [
          DialogButton(
            onPressed: () => {
              if (taskPage.formKey.currentState.validate()) {
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
                                    "New task successfully added",
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
                createTask(taskPage),
                }
            },
            child: Text(
              "CREATE TASK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  createTask(AddTaskPage taskPage) async {
    String taskName = taskPage.controllerTaskName.text;
    String username = taskPage.controllerPeople.text;
    String description = taskPage.controllerDescription.text;

    debugPrint(taskPage.controllerDate.text);
    DateTime date = taskPage.controllerDate.text != "" ? DateTime.parse(taskPage.controllerDate.text) : null;

    User user = username != null ? await StorageUtils.getUser(username) : null;
    Task task = Task(taskName, date, user, description);
    widget.event.tasks.add(task);
    bool updated = await StorageUtils.updateEvent(widget.event);
  }



  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

}

