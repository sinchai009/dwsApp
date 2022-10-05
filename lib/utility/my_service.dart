// ignore_for_file: avoid_print

import 'package:dwrapp/models/sqlite_model.dart';
import 'package:dwrapp/utility/my_dialog.dart';
import 'package:dwrapp/utility/sqllite_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyService {
  Future<void> aboutNotification({required BuildContext context}) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    String? token = await firebaseMessaging.getToken();
    print('## token ===> $token');

    FirebaseMessaging.onMessage.listen((event) {
      String? title = event.notification!.title;
      String? body = event.notification!.body;
      print('## OnMassage ===> title= $title, body = $body');

      MyDialog(context: context).normalDialog(title: title!, body: body!);
      processAddNiti(title: title, body: body);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      String? title = event.notification!.title;
      String? body = event.notification!.body;
      print('## OnOpenApp ===> title= $title, body = $body');
      MyDialog(context: context).normalDialog(title: title!, body: body!);
      processAddNiti(title: title, body: body);
    });
  }

  Future<void> processAddNiti(
      {required String title, required String body}) async {
    SQLiteModel sqLiteModel = SQLiteModel(title: title, body: body);
    await SQLiteHelper()
        .insertValueToDatabase(sqLiteModel: sqLiteModel)
        .then((value) => print('## Insert SQL Success'));
  }

  String changeDateToDate({required DateTime dateTime}) {
    // DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    // DateFormat dateFormat = DateFormat.yMMMMEEEEd('th');
    // DateFormat dateFormat = DateFormat.yMMMMd('th');
    // DateFormat dateFormat = DateFormat('EEEEที่ d เดือน MMMM ปี  y', 'th');
    DateFormat dateFormat = DateFormat('d MMMM y', 'th');

    String result = dateFormat.format(dateTime);

    return result;
  }

  String changeDateToTime({required DateTime dateTime}) {
    DateFormat dateFormat = DateFormat('HH:mm');

    String result = dateFormat.format(dateTime);

    return result;
  }
}
