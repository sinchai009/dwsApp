// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_interpolation_to_compose_strings
import 'package:dwrapp/bodys/main_page.dart';
import 'package:dwrapp/states/detail_station.dart';
import 'package:dwrapp/utility/my_constant.dart';
import 'package:dwrapp/widgets/widget_image_internet.dart';
import 'package:flutter/material.dart';

import 'package:dwrapp/models/station_all_model.dart';
import 'package:dwrapp/widgets/widget_text.dart';

import '../widgets/widget_text_buttom.dart';

class ListStation extends StatefulWidget {
  final List<StationAllModel> stationAllModels;
  const ListStation({
    Key? key,
    required this.stationAllModels,
  }) : super(key: key);

  @override
  State<ListStation> createState() => _ListStationState();
}

class _ListStationState extends State<ListStation> {
  var stationAllModels = <StationAllModel>[];

  @override
  void initState() {
    super.initState();
    stationAllModels = widget.stationAllModels;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return ListView.builder(
        itemCount: stationAllModels.length,
        itemBuilder: (context, index) => Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8, right: 16, top: 8),
              decoration: MyConstant().curveBox(),
              width: boxConstraints.maxWidth * 0.35,
              height: boxConstraints.maxWidth * 0.35,
              child: WidgetImageInternet(
                  url:
                      '${MyConstant.domain}/dwr/image/station/${stationAllModels[index].image}'),
            ),
            Container(
              margin: const EdgeInsets.only(right: 8),
              width: boxConstraints.maxWidth * 0.65 - 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetText(
                    text: stationAllModels[index].title +
                        ' (' +
                        stationAllModels[index].station_id +
                        ')',
                    textStyle: MyConstant().h2Style(),
                  ),
                  WidgetText(
                      text:
                          'ต.${stationAllModels[index].tumbon} อ.${stationAllModels[index].amphoe} จ.${stationAllModels[index].province} ${stationAllModels[index].postcode}'),
                  WidgetTextButtom(
                    label: 'รายละเอียด ...',
                    pressFunc: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(stationAllModel: stationAllModels[index]),));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
