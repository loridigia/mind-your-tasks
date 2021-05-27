import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:mind_your_tasks/models/Event.dart';
import 'package:mind_your_tasks/models/Task.dart';
import 'package:mind_your_tasks/models/User.dart';
import 'package:mind_your_tasks/screens/calendar_page.dart';
import 'package:mind_your_tasks/screens/event/add_event.dart';
import 'package:mind_your_tasks/screens/event/event_home_page.dart';
import 'package:mind_your_tasks/screens/task/search_task_page.dart';
import 'package:mind_your_tasks/screens/welcomePage.dart';
import 'package:mind_your_tasks/storage_utils.dart';
import 'package:mind_your_tasks/theme/colors/light_colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../widgets/main_drawer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:mind_your_tasks/widgets/task_column.dart';
import 'package:mind_your_tasks/widgets/active_project_card.dart';
import 'package:mind_your_tasks/widgets/top_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  User user;
  List<Event> events;
  List<Event> activeEvents;
  List<Task> userTasks;
  var completedTasks = 0;
  var activeTasks = 0;
  var pendingTasks = 0;

  @override
  void initState() {
    super.initState();
  }

  setTasks(List<Event> events) {
    userTasks = [];
    completedTasks = 0;
    activeTasks = 0;
    pendingTasks = 0;
    events.forEach((event) {
      List<Task> allTasks = event.tasks;
      allTasks.forEach((task) {
        if (task.user.username == user.username) {
          userTasks.add(task);
          if (task.status == Status.COMPLETED) completedTasks++;
          else if (task.status == Status.ACTIVE) activeTasks++;
          else pendingTasks++;
        }
      });
    }
    );
  }

  Future<String> getData(String username) async {
    this.user = await StorageUtils.getUser(username);
    this.events = await StorageUtils.getEvents();
    this.activeEvents = [];
    events.forEach((element) {
      if (!element.ended) activeEvents.add(element);
    });
    debugPrint(events.length.toString());
    setTasks(activeEvents);
    return "ready";
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    initialData: false,
    future: getData("TestUser"),
    builder: (context, snapshot) => snapshot.connectionState == ConnectionState.done && snapshot.hasData ? _buildWidget(context, snapshot.data) : const SizedBox(),
  );

  Widget _buildWidget(BuildContext context, dynamic data) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          backgroundColor: LightColors.kDarkYellow,
          leading: IconButton(
            icon: Icon(Icons.calendar_today, color: Colors.black, size: 20),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CalendarPage()),
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0, top: 10),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WelcomePage()),
                  ),
                  child: Text("LOGOUT", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                )
            ),
          ]
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 120,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: 90.0,
                            lineWidth: 5.0,
                            animation: true,
                            percent: 0.75,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: LightColors.kRed,
                            backgroundColor: LightColors.kDarkYellow,
                            center: CircleAvatar(
                              backgroundColor: LightColors.kBlue,
                              radius: 35.0,
                              backgroundImage: AssetImage(
                                'assets/images/avatar.png',
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  user.username,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: LightColors.kDarkBlue,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  user.email,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('My Tasks'),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchTaskPage(tasks: userTasks, title: "My Tasks")),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: LightColors.kGreen,
                                  child: Icon(
                                    Icons.search,
                                    size: 25.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          TaskColumn(
                            icon: Icons.alarm,
                            iconBackgroundColor: LightColors.kRed,
                            title: 'Pending',
                            subtitle: '$pendingTasks tasks',
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TaskColumn(
                            icon: Icons.replay,
                            iconBackgroundColor: LightColors.kDarkYellow,
                            title: 'Active',
                            subtitle: '$activeTasks tasks',
                          ),
                          SizedBox(height: 15.0),
                          TaskColumn(
                            icon: Icons.check,
                            iconBackgroundColor: Color.fromRGBO(67, 147, 31, 0.6),
                            title: 'Completed',
                            subtitle: '$completedTasks tasks',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          subheading('Active Event'),
                          GestureDetector(
                            onTap: () {
                              _onAddEvent(context);
                            },
                            child: addIcon(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: build_active_events(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onAddEvent(context) {
    // Reusable alert style
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromRight,
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

    AddEventPage eventPage = AddEventPage();
    Alert(
        context: context,
        style: alertStyle,
        type: AlertType.none,
        title: "Create new Event",
        content: eventPage,
        buttons: [
          DialogButton(
            onPressed: () => {
              if (eventPage.formKey.currentState.validate()) {
                Navigator.pop(context),
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                    SnackBar(
                      content:
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                "New event created",
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
                createEvent(eventPage),
                setState(() {}),
              }
            },
            child: Text(
              "CREATE EVENT",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  Future<bool> createEvent(AddEventPage eventPage) async {

    String eventName = eventPage.controllerEventName.text;
    DateTime date = eventPage.controllerDate.text != "" ? DateTime.parse(eventPage.controllerDate.text) : null;

    Event event = Event(eventName, date, [user]);
    return await StorageUtils.addNewEvent(event);
  }

  List<Widget> build_active_events() {
    List<Widget> list = [];
    List<Widget> event_cards = [];
    activeEvents.forEach((event) {
      event_cards.add(build_event_card(event));
    });

    if (event_cards.length % 2 != 0) event_cards.add(
        Expanded(
          flex: 48,
          child: Container(),
        )
    );

    for (var i = 0; i < event_cards.length; i += 2) {
      list.add(
        Row(
          children: <Widget>[
            event_cards[i],
            Expanded(
              flex: 4,
              child: Container(),
            ),
            event_cards[i+1]
          ],
        ),
      );
    }
    return list;
  }

  Widget build_event_card(Event event){
    return Expanded(
      flex: 48,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventHomePage(event: event)),
          );
        },
        child: generateProjectCard(LightColors.kBlue, 0.5, event.name, event.date),
      ),
    );
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

  static CircleAvatar addIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.add,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }

  static ActiveProjectsCard generateProjectCard(color, donePercent, title, date) {
    return ActiveProjectsCard(
        cardColor: color,
        loadingPercent: donePercent,
        title: title,
        date: date);
  }
}
