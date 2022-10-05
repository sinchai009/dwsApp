// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dwrapp/utility/my_constant.dart';
import 'package:dwrapp/widgets/widget_image.dart';
import 'package:dwrapp/widgets/widget_text.dart';
import 'package:dwrapp/widgets/widget_text_buttom.dart';
import 'package:flutter/material.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  void normalDialog({required String title, required String body}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: const SizedBox(
            width: 80,
            height: 80,
            child: WidgetImage(),
          ),
          title: WidgetText(
            text: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: WidgetText(text: body),
        ),
        actions: [
          WidgetTextButtom(
            label: 'OK',
            pressFunc: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
