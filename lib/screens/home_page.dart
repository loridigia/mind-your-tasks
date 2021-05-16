import 'dart:convert';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
  }

  Future<User> getUser(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = User("lollo", "ciao@gmail.com");
    bool read = await prefs.setString("lollo", json.encode(user));
    String data = prefs.getString("lollo");
    debugPrint(data);
    Map<String, dynamic> userMap = jsonDecode(data);
    User user2 = User.fromJson(userMap);
    return user2;
  }

  Future<Task> getTask(String name, DateTime date, User user, String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Task task = Task(name, date, user, description);
    bool read = await prefs.setString("task", json.encode(task));
    String data = prefs.getString("task");
    debugPrint(data);
    Map<String, dynamic> taskMap = jsonDecode(data);
    Task task2 = Task.fromJson(taskMap);
    return task2;
  }

  Future<String> getData(String username) async {
    this.user = await getUser(username);
    Task task = await getTask("prova task", DateTime.now(), user, "asd");
    return "ready";
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    initialData: false,
    future: getData("lollo"),
    builder: (context, snapshot) => snapshot.hasData ? _buildWidget(context, snapshot.data) : const SizedBox(),
  );

  Widget _buildWidget(BuildContext context, dynamic data) {
    T cast<T>(x) => x is T ? x : null;

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
                                  "asdasd",
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
                                  "asdasd",
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
