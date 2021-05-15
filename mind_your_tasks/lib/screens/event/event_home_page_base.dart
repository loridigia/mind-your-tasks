import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mind_your_tasks/theme/colors/light_colors.dart';
import 'package:mind_your_tasks/widgets/main_drawer.dart';
import 'package:mind_your_tasks/widgets/task_column.dart';
import 'package:mind_your_tasks/widgets/top_container.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../calendar_page.dart';
import '../project_creation.dart';

class EventHomePage extends StatefulWidget {
  EventHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EventHomePageState createState() => _EventHomePageState();
}

class _EventHomePageState extends State<EventHomePage> {
  @override
  Widget build(BuildContext context) {
    double percentage = 50/100;

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
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
              height: 90,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      Container(
                        child: Text(
                          'Project Name',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: LightColors.kDarkBlue,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      ],
                      ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          LinearPercentIndicator( //leaner progress bar
                            animation: true,
                            animationDuration: 1000,
                            lineHeight: 20.0,
                            width: 300,
                            percent: percentage,
                            center: Text(
                              "50%",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.blue[400],
                            backgroundColor: Colors.grey[300],
                          ),
                        ],
                      ),
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
                                child: addIcon(),
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
                            icon: Icons.blur_circular,
                            iconBackgroundColor: LightColors.kDarkYellow,
                            title: 'In Progress',
                            subtitle: '1 tasks now. 1 started',
                          ),
                          SizedBox(height: 15.0),
                          TaskColumn(
                            icon: Icons.check_circle_outline,
                            iconBackgroundColor: LightColors.kBlue,
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
                          SizedBox(height: 5.0),
                          Row(
                            children: <Widget>[],
                          ),
                          Row(
                            children: <Widget>[],
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


}