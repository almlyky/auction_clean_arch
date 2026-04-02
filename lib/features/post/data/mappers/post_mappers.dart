import 'package:auction_clean_arch/features/post/domain/entities/post_images_entity.dart';

import '../models/post_model.dart';
import '../models/post_images_model.dart';
import '../../domain/entities/post_entity.dart';

/// =======================
/// PostImage Mappers
/// =======================

extension PostImagesModelMapper on PostImagesModel {
  PostImagesEntity toEntity() {
    return PostImagesEntity(
      id: id,
      imageUrl: imageUrl,
    );
  }
}

extension PostImageEntityMapper on PostImagesEntity {
  PostImagesModel toModel() {
    return PostImagesModel(
      id: id,
      imageUrl: imageUrl,
    );
  }
}

/// =======================
/// Post Mappers
/// =======================

extension PostModelMapper on PostModel {
  PostEntity toEntity() {
    return PostEntity(
      id: id,
      name: name,
      address: address,
      discribtion: discribtion,
      price: price,
      status: status,
      productStatus: productStatus,
      createdAt: createdAt,
      userId: userId,
      categoryId: categoryId,
      fav: fav,
      images: images
          ?.map((imageModel) => imageModel.toEntity())
          .toList(),
    );
  }
}

extension PostEntityMapper on PostEntity {
  PostModel toModel() {
    return PostModel(
      id: id,
      name: name,
      address: address,
      discribtion: discribtion,
      price: price,
      status: status,
      productStatus: productStatus,
      createdAt: createdAt,
      userId: userId,
      categoryId: categoryId,
      fav: fav,
      images: images
          ?.map((imageEntity) => imageEntity.toModel())
          .toList(),
    );
  }
}
