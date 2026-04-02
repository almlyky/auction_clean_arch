import 'package:auction_clean_arch/features/auth/data/models/user_model.dart';

class ResponseLoginModel {
  final String accessToken;
  final UserModel user;

  ResponseLoginModel({required this.accessToken, required this.user});

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) {
    return ResponseLoginModel(
      accessToken: json['access_token'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
