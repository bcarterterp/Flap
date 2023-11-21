import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flap_app/data/source/network/mock/spoonacular_file_finder.dart';
import 'package:flutter/services.dart';

//This interceptor is in charge of returning the mock responses for API calls.
//It uses the SpoonacularFileFinder to figure out which file to return.
//This interceptor should only be used in mock flavor.
class MockInterceptor extends Interceptor {
  final String _jsonDir = 'assets/json/';

  final SpoonacularFileFinder _spoonacularFileFinder = SpoonacularFileFinder();

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final uri = Uri.parse(options.path);
    final jsonPath = _spoonacularFileFinder.getJsonPath(uri);

    if (jsonPath != null) {
      final resourcePath = _jsonDir + jsonPath;
      final data = await rootBundle.load(resourcePath);
      final map = json.decode(
        utf8.decode(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        ),
      );

      final response = Response(
        requestOptions: RequestOptions(),
        data: map,
        statusCode: 200,
      );
      return handler.resolve(response);
    }

    return handler.next(options);
  }
}
