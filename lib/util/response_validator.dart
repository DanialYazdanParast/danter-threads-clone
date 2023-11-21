import 'package:danter/util/exceptions.dart';
import 'package:dio/dio.dart';


mixin HttpResponseValidat {
  validatResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}
