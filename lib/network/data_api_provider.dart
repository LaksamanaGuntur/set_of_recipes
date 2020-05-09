import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:set_of_recipes/model/list_data.dart';
import 'package:set_of_recipes/model/recipes_data.dart';
import '../utils/constant.dart';
import '../utils/logs.dart';

class DataApiProvider {
  Dio _dio;

  DataApiProvider() {
    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _dio = Dio(options);
    _setupLoggingInterceptor();
  }

  Future<List<ListData>> getIngredients() async {
    try {
      Response response = await _dio.get("${BaseUrl.apiBaseUrl}${BaseUrl.ingredients}");
      return (response.data as List).map((model) => ListData.fromJson(model)).toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return List();
    }
  }

  Future<List<RecipesData>> getRecipes(String ingredients) async {
    try {
      Response response = await _dio.get("${BaseUrl.apiBaseUrl}${BaseUrl.recipes}");
      return (response.data as List).map((model) => RecipesData.fromJson(model)).toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return List();
    }
  }

  String _handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription = "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription = "Received invalid status code: ${error.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "SEND_TIMEOUT";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }

  void _setupLoggingInterceptor() {
    int maxCharactersPerLine = 200;

    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options) async {
          Logs.d("--> ${options.method} ${options.path}");
          Logs.d("Content type: ${options.contentType}");
          Logs.d("Headers: ${options.headers}");
          Logs.d("<-- END HTTP REQUEST");
          return options;
        },
        onResponse:(Response response) {
          Logs.d("--> ${response.statusCode} ${response.request.method} ${response.request.path}");
          String responseAsString = response.data.toString();
          if (responseAsString.length > maxCharactersPerLine) {
            int iterations =
            (responseAsString.length / maxCharactersPerLine).floor();
            for (int i = 0; i <= iterations; i++) {
              int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
              if (endingIndex > responseAsString.length) {
                endingIndex = responseAsString.length;
              }
              Logs.d(responseAsString.substring(
                  i * maxCharactersPerLine, endingIndex));
            }
          } else {
            Logs.d(response.data);
          }
          Logs.d("<-- END HTTP RESPONSE");
          return response;
        },
        onError: (DioError e) {
          _handleError(e);
          return  e;
        }
    ));
  }
}
