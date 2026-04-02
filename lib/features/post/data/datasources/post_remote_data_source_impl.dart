import 'dart:convert';
import 'dart:io';
import 'package:auction_clean_arch/core/network/dio_client.dart';
import 'package:auction_clean_arch/core/network/links_api.dart';
import 'package:auction_clean_arch/features/post/data/models/post_model.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:dio/dio.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPost();
  Future<List<PostModel>> getMyPost(int userId);

  Future<List<PostModel>> getPostByCategories({
    required int cateId,
    required String type,
  });
  Future<PostModel> addPost({
    required Map<String, dynamic> data,
    required List<File> images,
  });
  Future<PostModel> updatePost({
    required int postId,
    required Map<String, dynamic> data,
    required List<File> images,
    required List<int> deletImageIds,
  });
  Future<void> deletePost(int postId);
  Future<void> markPostAsSold(int postId);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  // final Dio dio;
  final DioClient dioClient;
  PostRemoteDataSourceImpl(this.dioClient);

  @override
  Future<void> deletePost(int postId) async {
    await dioClient.delete("${LinksApi.endpointPosts}/$postId");
  }

  @override
  Future<List<PostModel>> getPost() async {
    Response response = await dioClient.get(LinksApi.endpointPosts);
    return (response.data['data'] as List)
        .map((json) => PostModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<PostModel>> getPostByCategories({
    required int cateId,
    required String type,
  }) async {
    Response response = await dioClient.get(
      "${LinksApi.endpointCategories}/$cateId",
    );
    return (response.data['data']['posts'] as List)
        .map((json) => PostModel.fromJson(json))
        .toList();
  }

  @override
  Future<PostModel> updatePost({
    required int postId,
    required Map<String, dynamic> data,
    required List<File> images,
    required List<int> deletImageIds,
  }) async {
    List<MultipartFile> multipartFiles = [];
    for (File image in images) {
      // MultipartFile multipartFile = await MultipartFile.fromFile(image.path);
      multipartFiles.add(await MultipartFile.fromFile(image.path));
    }
    final FormData formData = FormData.fromMap({
      'data': data,
      'images[]': multipartFiles,
      'deleted_images_ids[]': deletImageIds,
    });

    Response response = await dioClient.post(
      endpoint: "${LinksApi.endpointUpdatePosts}/$postId",
      data: formData,
    );
    return PostModel.fromJson(response.data['data']);
  }

  @override
  Future<PostModel> addPost({
    required Map<String, dynamic> data,
    required List<File> images,
  }) async {
    List<MultipartFile> multipartFiles = [];
    for (File image in images) {
      // MultipartFile multipartFile = await MultipartFile.fromFile(image.path);
      multipartFiles.add(await MultipartFile.fromFile(image.path));
    }
    final FormData formData = FormData.fromMap({
      'data': data,
      'images[]': multipartFiles,
    });

    Response response = await dioClient.post(
      endpoint: LinksApi.endpointPosts,
      data: formData,
    );
    return PostModel.fromJson(response.data['data']);
  }

  @override
  Future<List<PostModel>> getMyPost(int userId) async {
    Response response = await dioClient.get(
      "${LinksApi.endpointPostByUser}/$userId",
    );
    return (response.data['data'] as List)
        .map((json) => PostModel.fromJson(json))
        .toList();
  }

  @override
  Future<void> markPostAsSold(int postId) async {
   await dioClient.post(
      endpoint: "${LinksApi.endpointMarkPostAsSold}/$postId",
    );
  }
}
