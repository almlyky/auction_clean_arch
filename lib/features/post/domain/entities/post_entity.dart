import 'package:auction_clean_arch/features/post/domain/entities/post_images_entity.dart';

class PostEntity {
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
  final List<PostImagesEntity>? images;

  PostEntity({
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
}
