
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mind_your_tasks/models/User.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {

  SettingsScreen({Key key, this.user}) : super(key: key);

  User user;
  final formKey = GlobalKey<FormState>();
  TextEditingController controllerOldPassword = new TextEditingController();
  TextEditingController controllerNewPassword = new TextEditingController();
  TextEditingController controllerConfirmPassword = new TextEditingController();

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool syncCalendar = true;
  bool notificationsEnabled = true;
  bool notification = true;
  bool fingerPrint = true;
  bool _passwordVisibleNewPass = true;
  bool _passwordVisibleConfirmPass = true;
  bool _passwordVisibleOldPass = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: buildSettingsList(),
    );
  }

  Widget buildSettingsList() {
    return SettingsList(
      sections: [
        SettingsSection(
          title: 'Common',
          tiles: [
            SettingsTile(
              enabled: false,
              title: 'Language',
              subtitle: 'English',
              leading: Icon(Icons.language),
              onPressed: (context) {},
            ),
          ],
        ),
        SettingsSection(
          title: 'Account',
          tiles: [
            SettingsTile(title: "Username", subtitle: widget.user.username, leading: Icon(Icons.person), enabled: false),
            SettingsTile(title: "Email", subtitle: widget.user.email, titleMaxLines: 20, leading: Icon(Icons.email), enabled: false),
            SettingsTile(title: "Password", subtitle: '***********',leading: Icon(Icons.lock),
              onPressed: (context) {
                _onChangePassword(context);
            },
            ),
            SettingsTile.switchTile(
              title: 'Login with fingerprint',
              leading: Icon(Icons.fingerprint),
              switchValue: fingerPrint,
              onToggle: (bool value) {
                setState(() {
                  fingerPrint = value;
                });
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Misc',
          tiles: [
            SettingsTile.switchTile(
              title: 'Sync events with calendar',
              leading: Icon(Icons.event),
              switchValue: syncCalendar,
              onToggle: (bool value) {
                setState(() {
                  syncCalendar = value;
                  notificationsEnabled = value;
                  notification = value;
                });
              },
            ),
            SettingsTile.switchTile(
              title: 'Enable Notifications',
              enabled: notificationsEnabled,
              leading: Icon(Icons.notifications_active),
              switchValue: notification,
              onToggle: (bool value) {
                setState(() {
                  notification = value;
                });
              },
            ),
          ],
        ),
        CustomSection(
          child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child:Column(
                children: [
                  Text(
                    'Mind Your Tasks: 0.7.5 ',
                    style: TextStyle(color: Color(0xFF777777)),
                  ),
                ],
              ),
            ),
            ),
          ],
    );
  }


  _onChangePassword(context) {
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

    Alert(
        context: context,
        style: alertStyle,
        type: AlertType.none,
        title: "Change Password",
        content: changePasswordContent(),
        buttons: [
          DialogButton(
            onPressed: () => {
            if (widget.formKey.currentState.validate()) {
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
                                "Password changed correctly",
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
                setState(() {}),
              },
            },
            child: Text(
              "SAVE PASSWORD",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
  
  changePasswordContent() {
    return Container(
      child: Form(
        key: widget.formKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _entryField("Old Password", oldPassword()),
          _entryField("New Password", newPassword()),
          _entryField("Confirm Password", confirmPassword()),
        ],
      ),
      ),
    );
  }

  Widget oldPassword() {
    return TextFormField(
        controller: widget.controllerOldPassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the current password';
          }
          return null;
        },
        obscureText: _passwordVisibleOldPass,
        decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisibleOldPass
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                _passwordVisibleOldPass = !_passwordVisibleOldPass;
                debugPrint("tap");
              });
            },
          ),));
  }

  Widget newPassword() {
    return TextFormField(
        controller: widget.controllerNewPassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the new password';
          }
          return null;
        },
        obscureText: _passwordVisibleNewPass,
        decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisibleNewPass
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                _passwordVisibleNewPass = !_passwordVisibleNewPass;
                debugPrint("tap");
              });
            },
          ),
        ));
  }

  Widget confirmPassword() {
    return TextFormField(
        obscureText: true,
        controller: widget.controllerConfirmPassword,
        validator: (value) {
          if (value == null || value.isEmpty || value != widget.controllerNewPassword.text) {
            return 'Passwords do not match ';
          }
          return null;
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisibleConfirmPass
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                _passwordVisibleConfirmPass = !_passwordVisibleConfirmPass;
                debugPrint("tap");
              });
            },
          ),));
  }

  Widget _entryField(String title, Widget textFormField) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          textFormField
        ],
      ),
    );
  }

}