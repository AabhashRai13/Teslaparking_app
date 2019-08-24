import 'dart:io';
import 'package:google_map/constant.dart';

import 'package:dio/dio.dart';

class APIPostRequest {
  Future<Map<String, dynamic>> makePostReqUsingDio(
      String url, FormData data) async {
    Response response;
    Dio dio = new Dio();
   
    response = await dio.post(url,
        data: data,
        options: new Options(contentType: ContentType("application", "json")));
    // String reply = response.data.toString().trim();
    return response.data;
  }
}
