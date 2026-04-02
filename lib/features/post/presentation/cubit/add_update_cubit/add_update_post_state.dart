import 'dart:io';

import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:equatable/equatable.dart';

class AddUpdatePostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loading extends AddUpdatePostState {}

class AddPostSuccess extends AddUpdatePostState {
  final PostEntity post;
  AddPostSuccess(this.post);
  @override
  List<Object?> get props => [post];
}

class UpdatePostSuccess extends AddUpdatePostState {
  final PostEntity post;
  UpdatePostSuccess(this.post);
  @override
  List<Object?> get props => [post];
}

class DeletePostSuccess extends AddUpdatePostState {
  final int postId;
  DeletePostSuccess(this.postId);
  @override
  List<Object?> get props => [postId];
}

class ChangeProductStatus extends AddUpdatePostState {}

class Error extends AddUpdatePostState {
  final String message;
  Error(this.message);
  @override
  List<Object> get props => [message];
}
