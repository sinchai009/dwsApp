

import 'package:dwrapp/states/detail_station.dart';
import 'package:dwrapp/states/main_home.dart';
import 'package:dwrapp/utility/my_constant.dart';
import 'package:dwrapp/utility/my_service.dart';
import 'package:dwrapp/widgets/widget_image.dart';
import 'package:dwrapp/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  String? showDate, showTime;

  @override
  void initState() {
    super.initState();
    findCurrentTime();
  }

  void findCurrentTime() {
    DateTime dateTime = DateTime.now();
    print('## dateTime ===> $dateTime');

    showDate = MyService().changeDateToDate(dateTime: dateTime);
    showTime = MyService().changeDateToTime(dateTime: dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailStation(),
                ),
                (route) => false);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              contentTop(),
              newLogo(),
              contentBottom(),
            ],
          ),
        ),
      ),
    );
  }

  Row contentBottom() {
    return Row(
      children: [
        const SizedBox(
          width: 100,
          height: 100,
          child: WidgetImage(
            path: 'images/logo.png',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                WidgetText(
                  text: 'กรมทรัพยากรน้ำ',
                  textStyle: MyConstant().h2BlueStyle(),
                ),
                WidgetText(
                  text: 'กระทรวงทรัพยากรธรรมชาติ',
                  textStyle: MyConstant().h2BlueStyle(),
                ),
                WidgetText(
                  text: 'และสิ่งแวดล้อม',
                  textStyle: MyConstant().h2BlueStyle(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Container newLogo() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: const WidgetImage(),
    );
  }

  Row contentTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetText(
              text: showTime ?? '',
              textStyle: MyConstant().h0Style(),
            ),
            WidgetText(
              text: showDate ?? '',
              textStyle: MyConstant().h2RedStyle(),
            ),
            
          ],
        ),
      ],
    );
  }
}
