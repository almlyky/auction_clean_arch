import 'package:auction_clean_arch/core/errors/exceptions.dart';
import 'package:auction_clean_arch/core/network/links_api.dart';
import 'package:auction_clean_arch/core/services/flutter_secure_storage_services.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;
  DioClient._internal(this._dio) {
    _dio.interceptors.addAll([
      // 1. إضافة الـ Auth Interceptor لجلب التوكن
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // استدعاء الـ Static Service التي أنشأناها سابقاً
          final token = await FlutterSecureStorageService.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // إذا انتهت صلاحية التوكن (401) يمكنك هنا توجيه المستخدم لصفحة Login
          if (e.response?.statusCode == 401) {
            // منطق الـ Logout التلقائي
          }
          return handler.next(e);
        },
      ),

      // 2. الـ LogInterceptor الذي أضفته أنت (مهم للتطوير)
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }
  static final DioClient _instance = DioClient._internal(
    Dio(
      BaseOptions(
        baseUrl: LinksApi.baseUrl,
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 3000),

        // headers: {
        //   "Content-Type": "application/json",
        // },
      ),
    ),
  );

  factory DioClient() => _instance;
  // Dio get dio => _dio;

  // Add your API methods here
  Future<Response> get(String endpoint) async {
    try {
      Response response = await _dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      throw handleException(e);
    }
  }

  Future<Response> post({
    required String endpoint,
    final dynamic data,
  }) async {
    try {
      Response response = await _dio.post(endpoint, data: data,);
      return response;
    }
    // return response;
    on DioException catch (e) {
      throw handleException(e);
    }
  }

  Future<void> delete(String endpoint) async {
    try {
      await _dio.delete(endpoint);
    }
    // return response;
    on DioException catch (e) {
      throw handleException(e);
    }
  }

  Future<void> update({
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      await _dio.put(endpoint, data: data);
    } on DioException catch (e) {
      throw handleException(e);
    }
  }
}
