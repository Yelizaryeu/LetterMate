import 'package:dio/dio.dart';

class ErrorHandler {
  Future<Never> handleError(DioError error) async {
    final Response<dynamic>? response = error.response;
    if (response == null) {
      throw Exception();
    } else {
      final int? statusCode = response.statusCode;
      if (statusCode != null) {
        if (statusCode == 400) {
          //TODO: Implement additional error handling
          throw Exception();
        }

        if (statusCode == 401) {
          throw Exception(error.toString());
        }

        if (statusCode >= 500) {
          //TODO; Implement additional errorHandling for BE exception
          throw Exception();
        }
      }

      throw Exception(error.toString());
    }
  }
}
