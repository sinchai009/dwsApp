// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dwrapp/utility/my_constant.dart';
import 'package:dwrapp/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class WidgetButtom extends StatelessWidget {
  final String label;
  final Function() pressFunc;
  const WidgetButtom({
    Key? key,
    required this.label,
    required this.pressFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressFunc,
      child: WidgetText(
        text: label,
        textStyle: MyConstant().h2WhiteStyle(),
      ),
    );
  }
}
