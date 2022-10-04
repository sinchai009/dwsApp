// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dwrapp/bodys/list_station.dart';
import 'package:dwrapp/bodys/main_page.dart';
import 'package:dwrapp/bodys/nitification_page.dart';
import 'package:dwrapp/bodys/setting_page.dart';
import 'package:dwrapp/utility/my_constant.dart';
import 'package:dwrapp/widgets/widget_text.dart';
import 'package:flutter/material.dart';

import 'package:dwrapp/models/station_all_model.dart';

class DetailStation extends StatefulWidget {
  final StationAllModel stationAllModel;
  final List<StationAllModel> stationAllModels;
  const DetailStation({
    Key? key,
    required this.stationAllModel,
    required this.stationAllModels,
  }) : super(key: key);

  @override
  State<DetailStation> createState() => _DetailStationState();
}

class _DetailStationState extends State<DetailStation> {
  var iconDatas = <IconData>[
    Icons.home_outlined,
    Icons.list_alt_outlined,
    Icons.notifications_outlined,
    Icons.settings_outlined,
  ];

  var titles = <String>[
    'หน้าหลัก',
    'รายการ',
    'แจ้งเตือน',
    'ตั้งค่า',
  ];

  var bodys = <Widget>[];
  var bottomNavigationBarItems = <BottomNavigationBarItem>[];

  int indexBody = 0;

  @override
  void initState() {
    super.initState();

    bodys.add(MainPage(stationAllModel: widget.stationAllModel));
    bodys.add(ListStation(stationAllModels: widget.stationAllModels));
    bodys.add(const NotificationPage());
    bodys.add(const SettingPage());

    for (var i = 0; i < titles.length; i++) {
      bottomNavigationBarItems.add(
        BottomNavigationBarItem(
            icon: Icon(
              iconDatas[i],
            ),
            label: titles[i]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyConstant.blue,
        title: WidgetText(
          text: widget.stationAllModel.title,
          textStyle: MyConstant().h2WhiteStyle(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
       
        items: bottomNavigationBarItems,
        currentIndex: indexBody,
        unselectedIconTheme: IconThemeData(color: MyConstant.blue),
        selectedIconTheme: IconThemeData(color: MyConstant.red),
        onTap: (value) {
          indexBody = value;
          setState(() {});
        },
      ),
      body: bodys[indexBody],
    );
  }
}
