import 'package:dio/dio.dart';
import 'error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException({required this.errorModel});
}

class NetworkException extends ServerException {
  NetworkException({required super.errorModel});
}

Exception handleException(DioException e) {
  // غيرناها لـ void لأنها ترمي خطأ دائماً
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return NetworkException(
        errorModel: ErrorModel(
          errorMessage: 'Connection Timeout',
          statusCode: 408,
        ),
      );

    case DioExceptionType.badResponse:
      // هنا نسحب الرسالة من السيرفر إذا وجدت
      final message = e.response?.data['error'].toString() ?? 'Server Error';
      return ServerException(
        errorModel: ErrorModel(
          errorMessage: message,
          statusCode: e.response?.statusCode ?? 0,
        ),
      );

    case DioExceptionType.connectionError:
      return NetworkException(
        errorModel: ErrorModel(
          errorMessage: 'No Internet Connection',
          statusCode: 0,
        ),
      );

    default:
      return ServerException(
        errorModel: ErrorModel(
          errorMessage: 'Something went wrong',
          statusCode: 0,
        ),
      );
  }
}
