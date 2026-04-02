import 'package:auction_clean_arch/core/constant/app_const.dart';
import 'package:auction_clean_arch/core/di/dependency_injection.dart';
import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/auth/data/models/user_model.dart';
import 'package:auction_clean_arch/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/add_post.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/delete_post.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/get_myposts.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/get_posts.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/get_posts_by_category.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/mark_post_sold.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final GetPosts _getPosts;
  final MarkPostAsSold _markPostAsSold;
  final GetPostsByCategory _getPostsByCategory;

  // final AuthRepository authRepository;
  final _userBox = getIt<Box<UserModel>>();
  PostCubit(
    this._getPosts,
    // this.authRepository,
    this._getPostsByCategory,
    this._markPostAsSold,
  ) : super(PostInitial()) {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    emit(PostLoading());
    Result<List<PostEntity>> result = await _getPosts();
    if (result.isSuccess) {
      final posts = result.data!;
      if (posts.isEmpty) {
        emit(PostEmpty());
      } else {
        emit(PostLoaded(posts));
      }
    } else {
      final failure = result.failure!;
      emit(PostError(failure.message));
    }
  }

  Future<void> fetchPostsByCategory(int catId) async {
    emit(PostLoading());
    Result<List<PostEntity>> result = await _getPostsByCategory(catId);
    if (result.isSuccess) {
      final posts = result.data!;
      if (posts.isEmpty) {
        emit(PostEmpty());
      } else {
        emit(PostLoaded(posts));
      }
    } else {
      final failure = result.failure!;
      emit(PostError(failure.message));
    }
  }

  void addPostToList(PostEntity post) {
    if (state is PostLoaded) {
      final currentPosts = List<PostEntity>.from((state as PostLoaded).posts);

      emit(PostLoaded([post, ...currentPosts]));
    }
  }

  void updatePostInList(PostEntity updatedPost) {
    if (state is PostLoaded) {
      final posts = (state as PostLoaded).posts.map((post) {
        return post.id == updatedPost.id ? updatedPost : post;
      }).toList();

      emit(PostLoaded(posts));
    }
  }

  void removePostFromList(int postId) {
    if (state is PostLoaded) {
      final posts = List<PostEntity>.from((state as PostLoaded).posts)
        ..removeWhere((post) => post.id == postId);

      emit(PostLoaded(posts));
    }
  }

  Future<void> markPostAsSold(int postId) async {
    final result = await _markPostAsSold(postId);
    if (result.isSuccess) {}
  }

  String getUserName() {
    final user = _userBox.get(AppConst.keyUserBox);
    return user?.name ?? 'مستخدم';
  }

  String getUserPhone() {
    final user = _userBox.get(AppConst.keyUserBox);
    return user?.phone ?? '';
  }

  void changeImageIndex(int index) {
    if (state is PostLoaded) {
      emit((state as PostLoaded).copyWith(index));
    }
  }

  String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60 || diff.inMinutes < 40) {
      return 'now';
    } else if (diff.inMinutes < 60) {
      return 'قبل ${diff.inMinutes} دقيقة';
    } else if (diff.inHours < 24) {
      return 'قبل ${diff.inHours} ساعة';
    } else if (diff.inDays < 30) {
      return 'قبل ${diff.inDays} يوم';
    } else if (diff.inDays < 365) {
      return 'قبل ${diff.inDays ~/ 30} شهر';
    } else {
      return 'قبل ${diff.inDays ~/ 365} سنة';
    }
  }
}
