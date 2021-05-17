import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mind_your_tasks/models/Event.dart';
import 'package:mind_your_tasks/models/Task.dart';
import 'package:mind_your_tasks/models/User.dart';
import 'package:mind_your_tasks/screens/calendar_page.dart';
import 'package:mind_your_tasks/screens/event/event_home_page.dart';
import 'package:mind_your_tasks/screens/project_creation.dart';
import 'package:mind_your_tasks/theme/colors/light_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  @override
  void initState() {
    super.initState();
    setInitStuff();
  }

  setInitStuff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    User user = User("TestUser", "test-email@gmail.com");
    Task task = Task("Test1", DateTime.fromMillisecondsSinceEpoch(1625077149), user, "Funny party at mario's home");
    Task task2 = Task("Test2", DateTime.fromMillisecondsSinceEpoch(1625077149), user, "SOMETHING TO DO");
    Task task3 = Task("Test3", DateTime.fromMillisecondsSinceEpoch(1625077149), user, "SOMETHING ELSE TO DO");

    Event event = Event("Party night", DateTime.fromMillisecondsSinceEpoch(1625077149), [user]);
    event.addTask(task);
    event.addTask(task2);
    event.addTask(task3);

    List<String> events = [json.encode(event)];

    bool setUser = await prefs.setString("TestUser", json.encode(user));
    bool setEvents = await prefs.setStringList("Events", events);
  }

  Future<User> getUser(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(username);
    User user = User.fromJson(json.decode(data));
    return user;
  }

  Future<List<Event>> getEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList("Events");
    debugPrint(list.getRange(0, 1).first);
    List<Event> events = [];
    Set<String> set = list.toSet();
    set.forEach((element) {
      events.add(Event.fromJson(jsonDecode(element)));
    });
    return events;
  }


  Future<String> getData(String username) async {
    this.user = await getUser(username);
    this.events = await getEvents();
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
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
      ),
      drawer: MainDrawer(),
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
                                        builder: (context) => CalendarPage()),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: LightColors.kGreen,
                                  child: Icon(
                                    Icons.list,
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
                            title: 'To Do',
                            subtitle: '5 tasks now. 1 started',
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TaskColumn(
                            icon: Icons.replay,
                            iconBackgroundColor: LightColors.kDarkYellow,
                            title: 'In Progress',
                            subtitle: '1 tasks now. 1 started',
                          ),
                          SizedBox(height: 15.0),
                          TaskColumn(
                            icon: Icons.check,
                            iconBackgroundColor: Color.fromRGBO(67, 147, 31, 0.6),
                            title: 'Done',
                            subtitle: '18 tasks now. 13 started',
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
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('Active Event'),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProjectCreation()),
                                  );
                                },
                                child: addIcon(),
                              ),
                            ],
                          ),
                          SizedBox(height: 3.0),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 48,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EventHomePage(title: "ciao")),
                                    );
                                  },
                                  child: generateProjectCard(LightColors.kBlue, 0.5, "ciao", "subtitle"),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(),
                              ),
                              Expanded(
                                flex: 48,
                                child: generateProjectCard(LightColors.kBlue, 0.5, "ciao", "subtitle"),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 48,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EventHomePage(title: "ciao")),
                                    );
                                  },
                                  child: generateProjectCard(LightColors.kBlue, 0.5, "ciao", "subtitle"),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(),
                              ),
                              Expanded(
                                flex: 48,
                                child: generateProjectCard(LightColors.kBlue, 0.5, "ciao", "subtitle"),
                              )
                            ],
                          ),
                        ],
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

  static ActiveProjectsCard generateProjectCard(color, donePercent, title, subtitle) {
    return ActiveProjectsCard(
        cardColor: color,
        loadingPercent: donePercent,
        title: title,
        subtitle: subtitle);
  }
}
