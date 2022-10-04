// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:js_util';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:dio/dio.dart';
import 'package:dwrapp/models/rain_model.dart';
import 'package:dwrapp/utility/my_constant.dart';
import 'package:dwrapp/widgets/widget_image_internet.dart';
import 'package:dwrapp/widgets/wudget_progress.dart';
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

  int lineChartChoose = 0;

  @override
  void initState() {
    super.initState();
    stationAllModel = widget.stationAllModel;
    readRainData();
  }

  Future<void> readRainData() async {
    String path =
        '${MyConstant.domain}/dwr/service/rain/rain.php?stn_id=${stationAllModel!.station_id}';

    await Dio().get(path).then((value) {
      var response = value.data['response'];

      for (var element in response) {
        RainModel rainModel = RainModel.fromMap(element);
        rainModels.add(rainModel);
        double pm25 = double.parse(rainModel.pm25.toString());
        pm25s.add(pm25);

        pm10s.add(double.parse(rainModel.pm10.toString()));
        soils.add(double.parse(rainModel.soil.toString()));
        rains.add(double.parse(rainModel.r15m.toString()));
      }

//Add DashBoard
      gridWidgets.add(createWidget(
          head: 'PM25',
          value: rainModels[0].pm25.toString(),
          unit: ' มคก/ตรม'));
      gridWidgets.add(createWidget(
          head: 'PM10',
          value: rainModels[0].pm10.toString(),
          unit: ' มคก/ตรม'));
      gridWidgets.add(createWidget(
          head: 'ฝน', value: rainModels[0].r15m.toString(), unit: ' มม.'));
      gridWidgets.add(createWidget(
          head: 'Battary',
          value: rainModels[0].v_battery.toString(),
          unit: ' Volt'));
      gridWidgets.add(createWidget(
          head: 'Soil', value: rainModels[0].soil.toString(), unit: ' Volt'));

      load = false;
      setState(() {});
    });
  }

  Widget createWidget(
      {required String head, required String value, required String unit}) {
    return Container(
      decoration: MyConstant().curveBox(),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return load ? const WidgetProgress() : showContent(boxConstraints);
    });
  }

  ListView showContent(BoxConstraints boxConstraints) {
    return ListView(
      children: [
        newImage(boxConstraints),
        dashBoard(),
        WidgetText(
          text: 'กราฟแสดงผล',
          textStyle: MyConstant().h2RedStyle(),
        ),
        showGraph(boxConstraints)
      ],
    );
  }

  Container showGraph(BoxConstraints boxConstraints) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: MyConstant().curveBox(),
      width: boxConstraints.maxWidth,
      height: boxConstraints.maxWidth * 0.8,
      child: Sparkline(
        data: pm10s,
        enableGridLines: true,
        //gridLinelabelPrefix: 'มคก. ',
        gridLineLabelPrecision: 3,
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
      child: WidgetImageInternet(
          url:
              '${MyConstant.domain}/dwr/image/station/${stationAllModel!.image}'),
    );
  }
}
