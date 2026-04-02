import 'dart:io';

import 'package:auction_clean_arch/core/constant/app_const.dart';
import 'package:auction_clean_arch/core/di/dependency_injection.dart';
import 'package:auction_clean_arch/core/utils/enums.dart';
import 'package:auction_clean_arch/features/auth/data/models/user_model.dart';
import 'package:auction_clean_arch/features/post/data/models/post_model.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/add_post.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/delete_post.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/update_post.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/add_update_cubit/add_update_post_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class AddUpdatePostCubit extends Cubit<AddUpdatePostState> {
  final AddPost _addPost;
  final UpdatePost _updatePost;
  final DeletePost _deletePost;

  AddUpdatePostCubit(this._addPost, this._updatePost, this._deletePost)
    : super(AddUpdatePostState());

  // =========================================================== //
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController address = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // =========================================================== //

  // status product if used or new
  String productStatus = ProductStatus.used;

  // status for post if available or sold
  String postStatus = PostStatus.available;

  final _userBox = getIt<Box<UserModel>>();

  void initPostData(PostEntity postEntity) {
    name.text = postEntity.name ?? '';
    description.text = postEntity.discribtion ?? '';
    price.text = postEntity.price != null ? postEntity.price.toString() : '';
    address.text = postEntity.address ?? '';
    productStatus = postEntity.productStatus!;
  }

  Future<void> addPosts(List<File> images, int categoryId) async {
    emit(Loading());
    PostEntity postEntity = PostEntity(
      name: name.text,
      discribtion: description.text,
      price: int.parse(price.text),
      address: address.text,
      productStatus: productStatus,
      status: postStatus,
      userId: _userBox.get(AppConst.keyUserBox)!.id,
      // userId: Services.user!.id!,
      categoryId: categoryId,
    );
    final result = await _addPost(postEntity, images);
    if (result.isSuccess) {
      emit(AddPostSuccess(result.data!));
      resetInput();
    } else {
      emit(Error(result.failure!.message));
    }
  }

  Future<void> updatePosts(
    List<File> images,
    int postId,
    List<int> deletImageIds,
    int categoryId,
  ) async {
    emit(Loading());
    PostEntity postEntity = PostEntity(
      name: name.text,
      discribtion: description.text,
      price: int.parse(price.text),
      address: address.text,
      productStatus: productStatus,
      status: postStatus,
      userId: _userBox.get(AppConst.keyUserBox)!.id,
      categoryId: categoryId,
    );
    final result = await _updatePost(postId, postEntity, images, deletImageIds);
    if (result.isSuccess) {
      emit(UpdatePostSuccess(result.data!));
      resetInput();
    } else {
      emit(Error(result.failure!.message));
    }
  }

  Future<void> deletePosts(int postId) async {
    emit(Loading());
    final result = await _deletePost(postId);
    if (result.isSuccess) {
      emit(DeletePostSuccess(postId));
    } else {
      final failure = result.failure!;
      emit(Error(failure.message));
    }
  }

  void resetInput() {
    name.clear();
    description.clear();
    price.clear();
    address.clear();
  }

  void changeProductStatus(String productStatus) {
    productStatus = productStatus;
    emit(ChangeProductStatus());
  }
}
