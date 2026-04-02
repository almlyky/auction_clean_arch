
import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? phone;
  @HiveField(3)
  final int? isVerified;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      isVerified: json['is_verified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'phone': phone, 'is_verified': isVerified};
  }
}
