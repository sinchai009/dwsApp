// ignore_for_file: avoid_print

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dwrapp/models/sqlite_model.dart';
import 'package:dwrapp/utility/my_dialog.dart';
import 'package:dwrapp/utility/sqllite_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyService {
  Future<void> processSendNiti(
      {required String title,
      required String body,
      required String token}) async {
    String apiNoti =
        'https://www.androidthai.in.th/fluttertraining/apiNotification.php?isAdd=true&token=$token&title=$title&body=$body';

    await Dio().get(apiNoti).then((value) => print('## Send Noti Success'));
  }

  Future<void> aboutNotification({required BuildContext context}) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    String? token = await firebaseMessaging.getToken();
    print('## token ===> $token');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var docId = preferences.getString('docId');
    print('## ms 34 docId == > ${docId}');
    if (docId == null) {
      docId = 'DWS${Random().nextInt(10000000)}';
      preferences.setString('docId', docId).then((value) async {
        Map<String, dynamic> map = {};
        map['token'] = token;
        await FirebaseFirestore.instance
            .collection('user')
            .doc(docId)
            .set(map)
            .then((value) => print('## Insert Token Success'));
      });
    } else {
      updateTpken(docId: docId, token: token!);
    }

    FirebaseMessaging.onMessage.listen((event) {
      String? title = event.notification!.title;
      String? body = event.notification!.body;
      print('## 53 ms OnMassage ===> title= $title, body = $body');

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

  Future<void> updateTpken(
      {required String docId, required String token}) async {
    print('## ms 70 UpdateToken Work at docId ==> $docId');

    Map<String, dynamic> map = {};
    map['token'] = token;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(docId)
        .update(map)
        .then((value) => print('## ms 78 Update Token docId ==> $docId Sucess'));
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
