// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dwrapp/utility/my_constant.dart';
import 'package:flutter/material.dart';

class WidgetText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  const WidgetText({
    Key? key,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: textStyle ?? MyConstant().h3Style(),);
  }
}
