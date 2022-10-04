// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:dwrapp/models/station_all_model.dart';
import 'package:dwrapp/widgets/widget_text.dart';

class ListStation extends StatelessWidget {
  final List<StationAllModel> stationAllModels;
  const ListStation({
    Key? key,
    required this.stationAllModels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetText(text: 'ListStation Page');
  }
}
