// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:dwrapp/models/sqlite_model.dart';
import 'package:dwrapp/states/detail_station.dart';
import 'package:dwrapp/utility/my_constant.dart';
import 'package:dwrapp/utility/sqllite_helper.dart';
import 'package:dwrapp/widgets/widget_icon_buttom.dart';
import 'package:dwrapp/widgets/widget_progress.dart';
import 'package:dwrapp/widgets/widget_text.dart';

import '../models/station_all_model.dart';

class NotificationPage extends StatefulWidget {

final StationAllModel stationAllModel;
  final List<StationAllModel> stationAllModels;

  const NotificationPage({
    Key? key,
    required this.stationAllModel,
    required this.stationAllModels,
  }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var sqliteModels = <SQLiteModel>[];
  var load = true;
  bool? haveNoti;

  @override
  void initState() {
    super.initState();
    readAllNoti();
  }

  Future<void> readAllNoti() async {
    if (sqliteModels.isNotEmpty) {
      sqliteModels.clear();
    }

    await SQLiteHelper().readAllDatabase().then((value) {
      print('## value SQLite ---> $value');

      if (value.isEmpty) {
        haveNoti = false;
      } else {
        haveNoti = true;

        sqliteModels.addAll(value);
      }

      load = false;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? const WidgetProgress()
        : haveNoti!
            ? listNoti()
            : Center(
                child: WidgetText(
                  text: 'No Notification',
                  textStyle: MyConstant().h1Style(),
                ),
              );
  }

  Color sendColor({required String body}) {
    var colors = <Color>[
      Colors.green,
      Colors.yellow,
      Colors.red,
    ];

    int index = 0;

    var strings = body.split('#');
    print('## string[1] ===> ${strings[1]}');

    switch (strings[1]) {
      case 'green':
        index = 0;
        break;
      case 'yellow':
        index = 1;
        break;
      case 'red':
        index = 2;
        break;
      default:
        index = 0;
        break;
    }

    return colors[index];
  }

  ListView listNoti() {
    return ListView.builder(
      itemCount: sqliteModels.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(
            Icons.notifications,
            color: sqliteModels[index].body.contains('#')
                ? sendColor(body: sqliteModels[index].body)
                : Colors.blue,
            size: 36,
          ),
          title: WidgetText(
            text: sqliteModels[index].title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: WidgetText(text: sqliteModels[index].body),
          trailing: WidgetIconButtom(
            iconData: Icons.delete_forever,
            pressFunc: () async {
              await SQLiteHelper()
                  .deleteValueWhereId(idDelete: sqliteModels[index].id!)
                  .then((value) {
                // readAllNoti();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailStation(
                          stationAllModel: widget.stationAllModel,
                          stationAllModels: widget.stationAllModels, indexBody: 2,),
                    ),
                    (route) => false);
              });
            },
          ),
        );
      },
    );
  }
}
