import '../../domain/entities/post_images_entity.dart';

class PostImagesModel extends PostImagesEntity {
  PostImagesModel({super.id,super.isMain,super.imageUrl});

  factory PostImagesModel.fromJson(Map<String, dynamic> json) {
    return PostImagesModel(
      id: json['id'],
      imageUrl: json['image_url'],
      isMain: json['is_main'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'is_main': isMain,
    };
  }
}
