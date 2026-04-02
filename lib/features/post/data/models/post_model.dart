import 'package:auction_clean_arch/features/post/data/models/post_images_model.dart';

class PostModel {
  final int? id;
  final String? name;
  final String? address;
  final String? discribtion;
  final int? price;
  final String? status;
  final String? productStatus;
  final DateTime? createdAt;
  final int? userId;
  final int? categoryId;
  final int? fav;
  final List<PostImagesModel>? images;

  PostModel({
    this.id,
    this.name,
    this.address,
    this.discribtion,
    this.price,
    this.status,
    this.productStatus,
    this.createdAt,
    this.userId,
    this.categoryId,
    this.fav,
    this.images,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      address: json['address'],
      discribtion: json['discribtion'],
      price: int.parse(json['price'].toString()),
      status: json['status'],
      productStatus: json['product_status'],
      userId: int.parse(json['user_id'].toString()),
      categoryId: int.parse(json['category_id'].toString()),
      createdAt: DateTime.parse(json['created_at']),
      fav: int.parse(json['fav'].toString()),
      images: json['images'] != null
          ? (json['images'] as List)
                .map((v) => PostImagesModel.fromJson(v))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['discribtion'] = discribtion;
    data['price'] = price;
    data["status"] = status ?? "available";
    data['product_status'] = productStatus;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  
}
