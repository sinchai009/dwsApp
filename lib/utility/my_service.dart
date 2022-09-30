import 'package:intl/intl.dart';

class MyService {
  String changeDateToDate({required DateTime dateTime}) {
    // DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    // DateFormat dateFormat = DateFormat.yMMMMEEEEd('th');
    // DateFormat dateFormat = DateFormat.yMMMMd('th');
    // DateFormat dateFormat = DateFormat('EEEEที่ d เดือน MMMM ปี  y', 'th');
    DateFormat dateFormat = DateFormat('d MMMM y', 'th');

    String result = dateFormat.format(dateTime);

    return result;
  }

  String changeDateToTime({required DateTime dateTime}) {
    DateFormat dateFormat = DateFormat('HH:mm');

    String result = dateFormat.format(dateTime);

    return result;
  }
}
