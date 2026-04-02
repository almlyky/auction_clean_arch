import 'dart:io';

import 'package:auction_clean_arch/core/constant/app_const.dart';
import 'package:auction_clean_arch/core/errors/exceptions.dart';
import 'package:auction_clean_arch/core/errors/failures.dart';
import 'package:auction_clean_arch/core/errors/handle_result_reop.dart';
import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/post/data/datasources/post_remote_data_source_impl.dart';
import 'package:auction_clean_arch/features/post/data/mappers/post_mappers.dart';
import 'package:auction_clean_arch/features/post/data/models/post_images_model.dart';
import 'package:auction_clean_arch/features/post/data/models/post_model.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_images_entity.dart';
import '../../domain/repo/post_repo.dart';

class PostRepoImpl implements PostRepo {
  final PostRemoteDataSource remoteDataSource;
  PostRepoImpl(this.remoteDataSource);

  @override
  Future<Result<PostEntity>> addPost(
    PostEntity postEntity,
    List<File> images,
  ) async {
    return handleResult(
      remoteCall: () {
        return remoteDataSource.addPost(
          data: (postEntity.toModel()).toJson(),
          images: images,
        );
      },
      mapper: (post) => post.toEntity(),
    );
  }

  @override
  Future<Result<void>> deletePost(int postId) {
    return handleResultVoid(
      remoteCall: () => remoteDataSource.deletePost(postId),
    );
  }

  @override
  Future<Result<List<PostEntity>>> getPostByCategories({
    required int cateId,
    required String type,
  }) {
    return handleResult(
      remoteCall: () =>
          remoteDataSource.getPostByCategories(cateId: cateId, type: type),
      mapper: (data) => data.map((post) => post.toEntity()).toList(),
    );
  }

  @override
  Future<Result<List<PostEntity>>> getPosts() async {
    return handleResult(
      remoteCall: () => remoteDataSource.getPost(),
      mapper: (data) => data.map((post) => post.toEntity()).toList(),
    );
  }

  @override
  Future<Result<PostEntity>> updatePost(
    int postId,
    PostEntity postEntity,
    List<File> images,
    List<int> deletImageIds,
  ) {
    return handleResult(
      mapper: (post) => post.toEntity(),
      remoteCall: () {
        final data = (postEntity.toModel()).toJson();
        return remoteDataSource.updatePost(
          postId: postId,
          data: data,
          images: images,
          deletImageIds: deletImageIds,
        );
      },
    );
  }

  @override
  Future<Result<List<PostEntity>>> getMyPosts(int userId) {
    return handleResult(
      remoteCall: () => remoteDataSource.getMyPost(userId),
      mapper: (data) => data.map((post) => post.toEntity()).toList(),
    );
  }

  @override
  Future<Result<void>> markPostAsSold(int postId) {
    return handleResultVoid(
      remoteCall: () => remoteDataSource.markPostAsSold(postId)
    );
  }
}
