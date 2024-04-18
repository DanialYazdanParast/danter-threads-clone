import 'package:intl/intl.dart';

extension ChangeTime on String {
  String time() {
    var time = DateTime.fromMicrosecondsSinceEpoch(
        DateTime.parse(this).microsecondsSinceEpoch);
    var newFormat = DateFormat("Hm");
    String updatedtime = newFormat.format(time);
    return updatedtime;
  }

  bool textdirection() {
    RegExp persianRegExp = RegExp(r'^[\u0600-\u06FF]+');
    if (persianRegExp.hasMatch(this)) {
      return true;
    } else {
      return false;
    }
  }
}
