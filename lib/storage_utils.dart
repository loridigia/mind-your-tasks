import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/Event.dart';
import 'models/Task.dart';
import 'models/User.dart';

abstract class StorageUtils {

  static Future<bool> updateEvent(Event event) async {
    List<Event> events = await getEvents();
    List<String> updated = [];
    events.forEach((element) {
      if (element.UUID == event.UUID) updated.add(json.encode(event));
      else updated.add(json.encode(element));
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList("Events", updated);
  }

  static Future<bool> addNewEvent(Event event) async {
    List<Event> events = await getEvents();
    List<String> eventsString = [];
    events.add(event);
    events.forEach((element) {eventsString.add(json.encode(element));
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList("Events", eventsString);
  }

  static Future<Event> getEventByTask(Task task) async {
    List<Event> events = await getEvents();
    events.forEach((event) {
      event.tasks.forEach((element) {
        if (element.UUID == task.UUID) return event;
      });
    });
    return null;
  }


  static Future<List<Event>> getEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList("Events");
    List<Event> events = [];
    Set<String> set = list.toSet();
    set.forEach((element) {
      events.add(Event.fromJson(jsonDecode(element)));
    });
    return events;
  }

  static Future<User> getUser(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(username);
    User user = User.fromJson(json.decode(data));
    return user;
  }

}