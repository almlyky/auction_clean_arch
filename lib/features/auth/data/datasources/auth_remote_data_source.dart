import 'package:auction_clean_arch/core/network/dio_client.dart';
import 'package:auction_clean_arch/core/network/links_api.dart';
import 'package:auction_clean_arch/features/auth/data/models/request_login_model.dart';
import 'package:auction_clean_arch/features/auth/data/models/response_login_model.dart';
import 'package:auction_clean_arch/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSource({required this.dioClient});

  Future<ResponseLoginModel> login({
    required String phone,
    required String password,
  }) async {
    RequestLoginModel requestLoginModel = RequestLoginModel(
      phone: phone,
      password: password,
    );
    Response response = await dioClient.post(
      endpoint: LinksApi.endpointLogin,
      data: requestLoginModel.toJson(),
    );
    return ResponseLoginModel.fromJson(response.data['data']);
  }
}
