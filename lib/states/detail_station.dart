// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_interpolation_to_compose_strings
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'package:dwrapp/bodys/list_station.dart';
import 'package:dwrapp/bodys/main_page.dart';
import 'package:dwrapp/bodys/nitification_page.dart';
import 'package:dwrapp/bodys/setting_page.dart';
import 'package:dwrapp/models/station_all_model.dart';
import 'package:dwrapp/states/main_home.dart';
import 'package:dwrapp/utility/my_constant.dart';
import 'package:dwrapp/utility/sqllite_helper.dart';
import 'package:dwrapp/widgets/widget_icon_buttom.dart';
import 'package:dwrapp/widgets/widget_text.dart';

class DetailStation extends StatefulWidget {
  final StationAllModel stationAllModel;
  final List<StationAllModel> stationAllModels;
  final int? indexBody;
  const DetailStation({
    Key? key,
    required this.stationAllModel,
    required this.stationAllModels,
    this.indexBody,
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
  int amountNoti = 0;
  bool load = true;

  @override
  void initState() {
    super.initState();

    indexBody = widget.indexBody ?? 0;

    findSqliteData();

    bodys.add(MainPage(stationAllModel: widget.stationAllModel));
    bodys.add(ListStation(stationAllModels: widget.stationAllModels));
    bodys.add(NotificationPage(
      stationAllModel: widget.stationAllModel,
      stationAllModels: widget.stationAllModels,
    ));
    bodys.add(const SettingPage());
  }

  Future<void> findSqliteData() async {
    var result = await SQLiteHelper().readAllDatabase();
    if (result.isNotEmpty) {
      amountNoti = result.length;
    }
    load = false;
    createNavBarItem();
    setState(() {});
  }

  void createNavBarItem() {
    for (var i = 0; i < titles.length; i++) {
      bottomNavigationBarItems.add(
        BottomNavigationBarItem(
          icon: i == 2
              ? Badge(
                  badgeContent: Text(
                    amountNoti.toString(),
                    style: MyConstant().h3Style(color: Colors.white),
                  ),
                  child: Icon(iconDatas[i]),
                )
              : Icon(iconDatas[i]),
          label: titles[i],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: WidgetIconButtom(
          iconData: Icons.arrow_back,
          pressFunc: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainHome(),
                ),
                (route) => false);
          },
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: MyConstant.blue,
        title: WidgetText(
          text: indexBody == 0
              ? widget.stationAllModel.title +
                  ' (' +
                  widget.stationAllModel.station_id +
                  ')'
              : titles[indexBody],
          textStyle: MyConstant().h2WhiteStyle(),
        ),
      ),
      bottomNavigationBar: load
          ? const SizedBox()
          : BottomNavigationBar(
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
