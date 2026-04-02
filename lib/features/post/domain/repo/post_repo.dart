import 'dart:io';

import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';

abstract class PostRepo {
  Future<Result<List<PostEntity>>> getPosts();
  Future<Result<List<PostEntity>>> getMyPosts(int userId);

  Future<Result<List<PostEntity>>> getPostByCategories({
    required int cateId,
    required String type,
  });
  Future<Result<PostEntity>> addPost(PostEntity postEntity,List<File> images);
  Future<Result<PostEntity>> updatePost(int postId,PostEntity postEntity,List<File> images,List<int> deletImageIds);
  Future<Result<void>> deletePost(int postId);
  Future<Result<void>> markPostAsSold(int postId);

}
