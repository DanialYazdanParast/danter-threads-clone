import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OnlineUserUatasource extends WidgetsBindingObserver {
  final Dio dio = Dio(BaseOptions(baseUrl: 'https://dan.chbk.run/api/'));
  final String userid;
  OnlineUserUatasource({required this.userid});

  @override
  void online() async {
    final body = <String, dynamic>{
      "online": true,
    };

    await dio.patch(
      'collections/users/records/$userid',
      data: body,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      final body = <String, dynamic>{
        "online": false,
      };

      await dio.patch(
        'collections/users/records/$userid',
        data: body,
      );
    }
    if (state == AppLifecycleState.resumed) {
      final body = <String, dynamic>{
        "online": true,
      };

      await dio.patch(
        'collections/users/records/$userid',
        data: body,
      );
    }
  }
}
