// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:dio/dio.dart';
import 'package:dwrapp/models/rain_model.dart';
import 'package:dwrapp/utility/my_constant.dart';
import 'package:dwrapp/widgets/widget_image_internet.dart';
import 'package:dwrapp/widgets/widget_progress.dart';
import 'package:flutter/material.dart';

import 'package:dwrapp/models/station_all_model.dart';
import 'package:dwrapp/widgets/widget_text.dart';

class MainPage extends StatefulWidget {
  final StationAllModel stationAllModel;
  const MainPage({
    Key? key,
    required this.stationAllModel,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  StationAllModel? stationAllModel;
  bool load = true;

  var rainModels = <RainModel>[];
  var gridWidgets = <Widget>[];

  var pm25s = <double>[];
  var pm10s = <double>[];
  var soils = <double>[];
  var rains = <double>[];
  var temps = <double>[];
  var batts = <double>[];

  var titles = <String>[
    'PM10',
    'PM25',
    'Rain',
    'Battary',
    'Soil',
    'Temp',
  ];

  var colorbools = <bool>[];

  var listDatas = <List<double>>[];

  int indexChoose = 0;

  @override
  void initState() {
    super.initState();
    stationAllModel = widget.stationAllModel;

    listDatas.add(pm10s);
    listDatas.add(pm25s);
    listDatas.add(rains);
    listDatas.add(batts);
    listDatas.add(soils);
    listDatas.add(temps);

    setupColorBools();

    readRainData();
  }

  void setupColorBools() {
    if (colorbools.isNotEmpty) {
      colorbools.clear();
    }

    for (var i = 0; i < 6; i++) {
      colorbools.add(false);
    }
    colorbools[indexChoose] = true;
  }

  Future<void> readRainData() async {
    String path =
        '${MyConstant.domain}/dwr/service/rain/rain.php?stn_id=${stationAllModel!.station_id}';

    await Dio().get(path).then((value) {
      var response = value.data['response'];

      for (var element in response) {
        RainModel rainModel = RainModel.fromMap(element);
        rainModels.add(rainModel);

        pm25s.add(double.parse(rainModel.pm25.toString()));
        pm10s.add(double.parse(rainModel.pm10.toString()));
        soils.add(double.parse(rainModel.soil.toString()));
        rains.add(double.parse(rainModel.r15m.toString()));
        temps.add(double.parse(rainModel.temp.toString()));
        batts.add(double.parse(rainModel.v_battery.toString()));
      }

//Add DashBoard
      processCreateWidgets();

      load = false;
      setState(() {});
    });
  }

  void processCreateWidgets() {
    if (gridWidgets.isNotEmpty) {
      gridWidgets.clear();
    }

    gridWidgets.add(createWidget(
        head: 'PM10',
        value: rainModels[0].pm10.toString(),
        unit: 'มคก/ลบ.ม.',
        index: 0));
    gridWidgets.add(createWidget(
        head: 'PM25',
        value: rainModels[0].pm25.toString(),
        unit: 'มคก/ลบ.ม.',
        index: 1));
    gridWidgets.add(createWidget(
        head: 'Rain',
        value: rainModels[0].r15m.toString(),
        unit: 'มม.',
        index: 2));
    gridWidgets.add(createWidget(
        head: 'Battary',
        value: rainModels[0].v_battery.toString(),
        unit: 'Volt',
        index: 3));
    gridWidgets.add(createWidget(
        head: 'Soil',
        value: rainModels[0].soil.toString(),
        unit: '%',
        index: 4));
    gridWidgets.add(createWidget(
        head: 'Temp',
        value: rainModels[0].temp.toString(),
        unit: '°C',
        index: 5));
  }

  Widget createWidget({
    required String head,
    required String value,
    required String unit,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        print('Your tab index ==> $index');
        indexChoose = index;
        setupColorBools();
        processCreateWidgets();
        setState(() {});
      },
      child: Container(
        decoration: MyConstant().curveBox(
            color: colorbools[index]
                ? Color.fromARGB(255, 148, 222, 152)
                : Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetText(
              text: head,
              textStyle: MyConstant().h2Style(),
            ),
            WidgetText(
              text: value,
              textStyle: MyConstant().h2BlueStyle(),
            ),
            WidgetText(text: unit)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: WidgetText(text: stationAllModel!.title,textStyle: MyConstant().h2WhiteStyle(),),),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return load ? const WidgetProgress() : showContent(boxConstraints);
    }),
    );
  }

  ListView showContent(BoxConstraints boxConstraints) {
    return ListView(
      children: [
        newImage(boxConstraints),
        dashBoard(),
        newTitle(),
        showGraph(boxConstraints)
      ],
    );
  }

  Container newTitle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: WidgetText(
        text: 'กราฟแสดงผล ${titles[indexChoose]}',
        textStyle: MyConstant().h2RedStyle(),
      ),
    );
  }

  Container showGraph(BoxConstraints boxConstraints) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: MyConstant().curveBox(),
      width: boxConstraints.maxWidth,
      height: boxConstraints.maxWidth * 0.7,
      padding: const EdgeInsets.all(20),
      child: Sparkline(
        data: listDatas[indexChoose],
        enableGridLines: true,
        lineWidth: 3,
        pointsMode: PointsMode.all,
        pointSize: 5,
        pointColor: Colors.red,
        gridLineLabelPrecision: 3,
        //averageLine: true,
        //averageLabel: true,
      ),
    );
  }

  Padding dashBoard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: gridWidgets.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 4, crossAxisSpacing: 4, crossAxisCount: 3),
        itemBuilder: (context, index) => gridWidgets[index],
      ),
    );
  }

  Container newImage(BoxConstraints boxConstraints) {
    return Container(
      width: boxConstraints.maxWidth,
      height: boxConstraints.maxWidth * 0.8,
      padding: const EdgeInsets.all(8.0),
      child: WidgetImageInternet(
          url:
              '${MyConstant.domain}/dwr/image/station/${stationAllModel!.image}'),
    );
  }
}
