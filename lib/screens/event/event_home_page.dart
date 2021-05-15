import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mind_your_tasks/screens/task/add_task.dart';
import 'package:mind_your_tasks/screens/task/search_task_page.dart';
import 'package:mind_your_tasks/theme/colors/light_colors.dart';
import 'package:mind_your_tasks/widgets/main_drawer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../widgets/task_container.dart';


class EventHomePage extends StatefulWidget {
  EventHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EventHomePageState createState() => _EventHomePageState();
}

class _EventHomePageState extends State<EventHomePage> {
  int cupertinoTabBarIIIValue = 0;
  int cupertinoTabBarIIIValueGetter() => cupertinoTabBarIIIValue;
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
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
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
                    "Luigi's birthday",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight:
                        FontWeight.w700,
                        fontSize: 20,
                        color: Colors.black
                    ),
                  ),)
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
                                                "10",
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
                                              const EdgeInsets.only(
                                                  left: 4, bottom: 3),
                                              child: Text(
                                                "13-04-2021",
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
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4),
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
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 18, bottom: 8),
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
                                        percent: percentage,
                                        lineHeight: 5,
                                        width: 90,
                                        linearStrokeCap: LinearStrokeCap.roundAll,
                                        backgroundColor: Colors.grey[100],
                                        progressColor: Color.fromRGBO(
                                            67, 147, 31, 1.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        '10 left',
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
                                        percent: percentage,
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
                                        '10 left',
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
                                        percent: percentage,
                                        lineHeight: 5,
                                        width: 90,
                                        linearStrokeCap: LinearStrokeCap.roundAll,
                                        backgroundColor: Colors.grey[100],
                                        progressColor: Color.fromRGBO(
                                            219, 20, 36, 1.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        '10 left',
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
              )
            ),
        ),
        Container(
                padding: EdgeInsets.symmetric(horizontal:1.0, vertical: 1.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                ),
                width: width,
                height: 210,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child:Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 60,
                            child: CupertinoTabBar.CupertinoTabBar(
                              const Color.fromRGBO(255, 255, 255, 1.0),
                              const Color(0xFFf7f7f7),
                              [
                                const Text(
                                  "Completed",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.00,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "SFProRounded",
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const Text(
                                  "Active",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.00,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "SFProRounded",
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const Text(
                                  "Pending",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.00,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "SFProRounded",
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                              cupertinoTabBarIIIValueGetter,
                                  (int index) {
                                setState(() {
                                  cupertinoTabBarIIIValue = index;
                                });
                              },
                              useShadow: true,
                              innerHorizontalPadding: 0,
                            ),
                        ),
                        Expanded(
                            flex: 10,
                            child:GestureDetector(
                              onTap: () => _onAddTask(context),
                              child: Icon(Icons.note_add, size: 22),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchTaskPage(color: Color.fromRGBO(246, 197, 15, 0.8))),
                                );
                              },
                              child: Icon(Icons.arrow_forward_ios, size: 22)
                          ),
                        ),
                      ],
                    ),
                    ),
                        Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                         _showTab(),
                        ],
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  _showTab() {
    if (cupertinoTabBarIIIValueGetter() == 0) return showTaskList(Color.fromRGBO(67, 147, 31, 1.0));
    else if (cupertinoTabBarIIIValueGetter() == 1) return showTaskList(Color.fromRGBO(246, 197, 15, 1.0));
    else return showTaskList(Color.fromRGBO(219, 20, 36, 1.0));
  }

  showTaskList(Color color) {
    return Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      height: 130.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => _onAlertButtonsPressed(context),
                            child: TaskContainer(
                                color: color,
                                taskName: "Buy Coke",
                                personName: "Mario Rossi",
                                date: "13/02/2021 10:30",
                                desc: "Description of something about something else to be cut..."),
                          ),
                          GestureDetector(
                            onTap: () => _onAlertButtonsPressed(context),
                            child: TaskContainer(
                                color: color,
                                taskName: "Buy Coke",
                                personName: "Mario Rossi",
                                date: "13/02/2021 10:30",
                                desc: "Description of something about something else to be cut..."),
                          ),
                          GestureDetector(
                            onTap: () => _onAlertButtonsPressed(context),
                            child: TaskContainer(
                                color: color,
                                taskName: "Buy Coke",
                                personName: "Mario Rossi",
                                date: "13/02/2021 10:30",
                                desc: "Description of something about something else to be cut..."),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }

  _onAlertButtonsPressed(context) {
    // Reusable alert style
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
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
        color: Color.fromRGBO(67, 147, 31, 0.8),
        fontSize: 25,
        fontWeight: FontWeight.w800
      ),
    );

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.none,
      title: "Completed Task",
        content: Padding(
              padding: const EdgeInsets.all(2),
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
                            Icon(Icons.sticky_note_2, size: 25)
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Column(
                          children: <Widget>[
                            Text(
                                "Buy Coke",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.assignment_ind, size: 25)
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Column(
                          children: <Widget>[
                            Text(
                                "Mario Rossi",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.access_time, size: 25)
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Column(
                          children: <Widget>[
                            Text(
                                "13-03-2021 15:30",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
                                "Description of the task, of course chars must be cut because all of them are too much, but hey here they fits!!",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300)
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "ASSIGN TO ME",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
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
          color: Color.fromRGBO(67, 147, 31, 0.8),
          fontSize: 22,
          fontWeight: FontWeight.w800
      ),
    );

    // Alert dialog using custom alert style
    Alert(
        context: context,
        style: alertStyle,
        type: AlertType.none,
        title: "Add Completed Task",
        content: AddTaskPage(),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "CREATE TASK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
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

