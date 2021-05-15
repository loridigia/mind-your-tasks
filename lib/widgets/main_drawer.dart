import 'package:flutter/material.dart';
import 'package:mind_your_tasks/screens/calendar_page.dart';
import 'package:mind_your_tasks/screens/home_page.dart';
import 'package:mind_your_tasks/screens/welcomePage.dart';
import 'package:mind_your_tasks/theme/colors/light_colors.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          /*
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: LightColors.kBlue),
            accountName: Text("Abass Makinde"),
            accountEmail: Text("abs@gmail.com"),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                child: Text(
                  "AM",
                  style: TextStyle(
                      color: Colors.pink,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ),
           */
          _createHeader(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()),
              );
            },
            child: ListTile(
              leading: Icon(Icons.home, color: Colors.pink),
              title: Text("Home Page"),
            ),
          ),
          InkWell(
            onTap: null,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CalendarPage()),
                );
              },
              leading: Icon(Icons.calendar_today_rounded, color: Colors.deepPurple),
              title: Text("Calendar"),
            ),
          ),
          InkWell(
            onTap: null,
            child: ListTile(
              onTap: (){Navigator.pushNamed(context, "/news");},
              leading: Icon(Icons.shopping_basket, color: Colors.red),
              title: Text("News"),
            ),
          ),
          Divider(),
          InkWell(
            onTap: null,
            child: ListTile(
              leading: Icon(Icons.help, color: Colors.green),
              title: Text("About"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WelcomePage()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.power_settings_new,
                color: Colors.black,
              ),
              title: Text("Log out"),
            ),
          )
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.all(0.0),
        padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image:  AssetImage('assets/images/background.png'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Somenthing",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }


}