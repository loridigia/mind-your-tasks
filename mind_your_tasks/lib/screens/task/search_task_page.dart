import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mind_your_tasks/screens/task/add_task.dart';
import 'package:mind_your_tasks/theme/colors/light_colors.dart';
import 'package:mind_your_tasks/widgets/main_drawer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SearchTaskPage extends StatefulWidget {
  SearchTaskPage({Key key, this.color}) : super(key: key);

  final Color color;

  @override
  _SearchTaskPageState createState() => _SearchTaskPageState();
}

class _SearchTaskPageState extends State<SearchTaskPage> {
  @override
  Widget build(BuildContext context) {
    int tasksNum = 8;
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 243, 248, 1.0),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          title: Text(
              "Search Task",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500)
          ),
          backgroundColor: Colors.blueAccent.withOpacity(0.5),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
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
                  color: Colors.blueAccent.withOpacity(0.5),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: TextFormField(
                              maxLines: 1,
                              style: TextStyle(fontSize: 13, color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.sticky_note_2,
                                  color: Colors.white,
                                ),
                                hintText: 'Task Name',
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 50,
                            child: TextFormField(
                              maxLines: 1,
                              style: TextStyle(fontSize: 13, color: Colors.white),
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
                              style: TextStyle(fontSize: 13, color: Colors.white),
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
                              style: TextStyle(fontSize: 13, color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.note,
                                  color: Colors.white,
                                ),
                                hintText: 'Description',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: GridView.builder(
                  itemCount: tasksNum,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0
                  ),
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: () => _onAlertButtonsPressed(context),
                      child: taskCard(widget.color),
                    );
                  },
                ),
              ),
            ],
          ),
      ),
    );
  }

  Container taskCard(Color color) {
    return Container(
      width: 170,
      height: 130,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: color,
        elevation: 2,
        child:Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.sticky_note_2, size: 16, color: Colors.white)
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
                                color: Colors.white,
                                fontSize: 13.0,
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
                        Icon(Icons.assignment_ind, size: 16, color: Colors.white)
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
                                color: Colors.white,
                                fontSize: 13.0,
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
                        Icon(Icons.access_time, size: 16, color: Colors.white)
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
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                child: Container(
                  height: 1,
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
                            "Description of the task, of course chars must be cut ...",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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

