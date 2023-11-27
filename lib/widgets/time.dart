
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePost extends StatelessWidget {
  const TimePost({
    super.key,
    required this.created,
  });

  final String created;

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now().difference(DateTime.parse(created));

    var newFormat = DateFormat("yy-MM-dd");
    String updatedtime = newFormat.format(DateTime.parse(created));
    return Text(
      time.inMinutes == 0
          ? 'Now'
          : time.inMinutes < 60
              ? '${time.inMinutes}m'
              : time.inHours < 24
                  ? '${time.inHours}h'
                  : time.inDays < 8
                      ? '${time.inDays}d'
                      : time.inDays >= 8
                          ? '${updatedtime}'
                          : '',
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}