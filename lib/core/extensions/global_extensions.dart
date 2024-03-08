import 'dart:io';
import 'dart:ui';

import 'package:intl/intl.dart';

extension ChangeTime on String {
  String time() {
    var time = DateTime.fromMicrosecondsSinceEpoch(
        DateTime.parse(this).microsecondsSinceEpoch);
    var newFormat = DateFormat("Hm");
    String updatedtime = newFormat.format(time);
    return updatedtime;
  }
}
