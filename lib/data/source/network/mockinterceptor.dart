import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class MockInterceptor extends Interceptor {
  
  final String _jsonDir = 'assets/json/';
  final String _jsonExtension = '.json';

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final resourcePath = _jsonDir + options.path + _jsonExtension;
    final data = await rootBundle.load(resourcePath);
    final map = json.decode(
      utf8.decode(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      ),
    );

    return Response(
      requestOptions: RequestOptions(),
      data: map,
      statusCode: 200,
    );
  }
}
