class RequestLoginModel {
  final String phone;
  final String password;

  RequestLoginModel({required this.phone, required this.password});

  Map<String, dynamic> toJson() {
    return {'phone': phone, 'password': password};
  }
}