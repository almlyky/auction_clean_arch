class ErrorModel {
  final String errorMessage;
  final int? statusCode;
  ErrorModel({required this.errorMessage, this.statusCode});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      errorMessage: json['error'] ,
      statusCode: json['status'],
    );
  }
}
