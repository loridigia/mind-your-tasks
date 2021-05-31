
import 'package:flutter/material.dart';
import 'package:mind_your_tasks/models/Event.dart';
import 'package:mind_your_tasks/models/Task.dart';
import 'package:mind_your_tasks/screens/task/task_details.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../storage_utils.dart';

class TaskUtils {

  static getAlertStyle(Status status, bool closeButton, bool overlayDismiss) {
    return AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: closeButton,
      isOverlayTapDismiss: overlayDismiss,
      descStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
      animationDuration: Duration(milliseconds: 200),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Colors.white,
        ),
      ),
      titleStyle: TextStyle(
          color: getColorFromStatus(status),
          fontSize: 25,
          fontWeight: FontWeight.w800
      ),
    );
  }

  static Status convertStatus(String statusString) {
    if (statusString == null || statusString == "") return null;
    if (statusString == "COMPLETED") return Status.COMPLETED;
    else if (statusString == "ACTIVE") return Status.ACTIVE;
    else return Status.PENDING;
  }

  static Event updateTaskInEvent(Task task, Event event) {
    List<Task> newList = [];
    event.tasks.forEach((element) {
      if (element.UUID == task.UUID) newList.add(task);
      else newList.add(element);
    });
    event.tasks = newList;
    return event;
  }

  static Color getColorFromStatus(Status status) {
    if (status == Status.COMPLETED) return Color.fromRGBO(67, 147, 31, 1.0);
    else if (status == Status.ACTIVE) return Color.fromRGBO(246, 197, 15, 1.0);
    else return Color.fromRGBO(219, 20, 36, 1.0);
  }
}