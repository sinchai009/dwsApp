import 'package:dio/dio.dart';
import 'package:dwrapp/models/station_all_model.dart';
import 'package:dwrapp/utility/my_constant.dart';
import 'package:dwrapp/widgets/widget_text.dart';
import 'package:dwrapp/widgets/wudget_progress.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  bool load = true, showDetail = false;
  var stationAllModels = <StationAllModel>[];
  Map<MarkerId, Marker> markers = {};

  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    String path = '${MyConstant.domain}/dwr/service/stations/';
    await Dio().get(path).then((value) {
      // print('## value ==> $value');

      var response = value.data['response'];
      //print('## response ==> $response');

      int index = 0;

      for (var element in response) {
        StationAllModel stationAllModel = StationAllModel.fromMap(element);
        stationAllModels.add(stationAllModel);

        MarkerId markerId = MarkerId(index.toString());
        Marker marker = Marker(
          markerId: markerId,
          position: LatLng(
            double.parse(stationAllModel.lat.trim()),
            double.parse(
              stationAllModel.lng.trim(),
            ),
          ),
          infoWindow: InfoWindow(
            title: stationAllModel.title,
            snippet: stationAllModel.station_id,
            onTap: () {
              print('## You tap marker index ==>  ${markerId.value}');
              showDetail = true;
              setState(() {});
            },
          ),
          onTap: () {
            showDetail = false;
            setState(() {
              
            });
          },
        );

        markers[markerId] = marker;
        index++;
      }

      load = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyConstant.blue,
        title: WidgetText(
          text: 'ต้นแบบสถานีพลังงานต่ำ',
          textStyle: MyConstant().h2WhiteStyle(),
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints) {
          return SizedBox(
            width: boxConstraints.maxWidth,
            height: boxConstraints.maxHeight,
            child: load
                ? const WidgetProgress()
                : Stack(
                    children: [
                      showMap(),
                      showDetail ? newDetail(boxConstraints) : const SizedBox(),
                    ],
                  ),
          );
        },
      ),
    );
  }

  SizedBox newDetail(BoxConstraints boxConstraints) {
    return SizedBox(
      width: boxConstraints.maxWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          WidgetText(
            text: 'test Name',
            textStyle: MyConstant().h2Style(),
          ),
        ],
      ),
    );
  }

  GoogleMap showMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(MyConstant.latMap, MyConstant.lngMap),
        zoom: 6,
      ),
      onMapCreated: (controller) {},
      markers: Set<Marker>.of(markers.values),
      zoomControlsEnabled: false,
    );
  }
}
