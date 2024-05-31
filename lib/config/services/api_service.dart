import 'package:dio/dio.dart';
import 'package:utor_technical_round/utils/constants/end_points.dart';
import 'package:utor_technical_round/utils/resources/request_response.dart';

class ApiService {
  Future<Dio> launchDio() async {
    Dio dio = Dio();

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["accept"] = 'application/json';

    dio.options.followRedirects = false;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.sendTimeout = const Duration(seconds: 10);

    dio.options.validateStatus = (s) {
      if (s != null) {
        return s < 500;
      } else {
        return false;
      }
    };
    return dio;
  }

  Future<RequestResponse> get({
    required String endPoint,
    Map<String, dynamic>? params,
  }) async {
    String? errorMessage;
    try {
      Dio dio = await launchDio();
      final response = await dio.get(
        '${EndPoints.baseUrl}/$endPoint',
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        return RequestResponse.fromJson(response.data);
      } else if (response.statusCode == 500) {
        return RequestResponse(false, error: 'Server Error');
      } else {
        return RequestResponse(false, error: 'Network Error');
      }
    } catch (error) {
      errorMessage = error.toString();
      print('@get error $error');
      print('@get error message: $errorMessage');
      return RequestResponse(false, error: errorMessage);
    }
  }

  // Future<RequestResponse> get({
  //   required String endPoint,
  //   params,
  // }) async {
  //   String? errorMessage;
  //   try {
  //     Dio dio = await launchDio();
  //     final response = await dio.get(
  //       '${EndPoints.baseUrl}/$endPoint',
  //       queryParameters: params,
  //     );

  //     if (response.statusCode == 200) {
  //       print(response.data);
  //       return RequestResponse.fromJson(response.data);
  //     } else if (response.statusCode == 500) {
  //       return RequestResponse(false, error: 'Server Error');
  //     } else {
  //       return RequestResponse(false, error: 'Network Error');
  //     }
  //   } catch (error) {
  //     print('@get error $error');
  //     print('@get error message: $errorMessage');
  //   }
  //   return RequestResponse.fromJson({'success': false, 'error': errorMessage});
  // }

  post({
    required String endPoint,
    data,
  }) async {
    final Response response;
    String? errorMessage;
    try {
      print('post base url:${EndPoints.baseUrl}/$endPoint');
      Dio dio = await launchDio();
      response = await dio.post(
        '${EndPoints.baseUrl}/$endPoint',
        data: data,
      );

      // Dio full response error handling checks

      if (response.statusCode == 200) {
        return RequestResponse.fromJson(response.data);
      } else if (response.statusCode == 500) {
        return RequestResponse(false, error: 'Server Error');
      } else {
        return RequestResponse(false, error: 'Network Error');
      }
    } catch (error) {
      print('@get error $error');
      print('@get error message: $errorMessage');
    }
    return RequestResponse.fromJson({'success': false, 'error': errorMessage});
  }

  put({
    required String endPoint,
    data,
  }) async {
    String? errorMessage;
    try {
      Dio dio = await launchDio();
      final response = await dio.put(
        '${EndPoints.baseUrl}/$endPoint',
        data: data,
      );
      if (response.statusCode == 200) {
        return RequestResponse.fromJson(response.data);
      } else if (response.statusCode == 500) {
        return RequestResponse(false, error: 'Server Error');
      } else {
        return RequestResponse(false, error: 'Network Error');
      }
    } catch (error) {
      print('@get error $error');
      print('@get error message: $errorMessage');
    }
    return RequestResponse.fromJson({'success': false, 'error': errorMessage});
  }

  delete({
    required String endPoint,
    params,
  }) async {
    String? errorMessage;
    try {
      Dio dio = await launchDio();
      final response = await dio.delete(
        '${EndPoints.baseUrl}/$endPoint',
        queryParameters: params,
      );
      if (response.statusCode == 200) {
        return RequestResponse.fromJson(response.data);
      } else if (response.statusCode == 500) {
        return RequestResponse(false, error: 'Server Error');
      } else {
        return RequestResponse(false, error: 'Network Error');
      }
    } catch (error) {
      print('@get error $error');
      print('@get error message: $errorMessage');
    }
    return RequestResponse.fromJson({'success': false, 'error': errorMessage});
  }
}
