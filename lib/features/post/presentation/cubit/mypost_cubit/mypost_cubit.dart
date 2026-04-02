import 'package:auction_clean_arch/core/constant/app_const.dart';
import 'package:auction_clean_arch/core/di/dependency_injection.dart';
import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/auth/data/models/user_model.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/get_myposts.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'mypost_state.dart';

class MypostCubit extends Cubit<MyPostState> {
  final GetMyposts _getMyposts;
  MypostCubit(this._getMyposts) : super(MypostInitial()) {
    fetchMyPosts();
  }

  final _userBox = getIt<Box<UserModel>>();

  Future<void> fetchMyPosts() async {
    final userId = _userBox.get(AppConst.keyUserBox)!.id;
    emit(MyPostLoading());
    Result<List<PostEntity>> result = await _getMyposts(userId!);
    if (result.isSuccess) {
      final posts = result.data!;
      if (posts.isEmpty) {
        emit(MyPostEmpty());
      } else {
        emit(MyPostLoaded(posts));
      }
    } else {
      final failure = result.failure!;
      emit(MyPostError(failure.message));
    }
  }

  void addPostToList(PostEntity post) {
    if (state is MyPostLoaded) {
      final currentPosts = List<PostEntity>.from((state as MyPostLoaded).posts);

      emit(MyPostLoaded([post, ...currentPosts]));
    }
  }

  void updatePostInList(PostEntity updatedPost) {
    if (state is MyPostLoaded) {
      final posts = (state as MyPostLoaded).posts.map((post) {
        return post.id == updatedPost.id ? updatedPost : post;
      }).toList();

      emit(MyPostLoaded(posts));
    }
  }

  void removePostFromList(int postId) {
    if (state is MyPostLoaded) {
      final posts = List<PostEntity>.from((state as MyPostLoaded).posts)
        ..removeWhere((post) => post.id == postId);

      emit(MyPostLoaded(posts));
    }
  }
}
