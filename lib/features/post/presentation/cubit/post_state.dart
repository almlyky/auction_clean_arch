part of 'post_cubit.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {}

final class PostLoaded extends PostState {
  final List<PostEntity> posts;
  final int index;

  const PostLoaded(this.posts, {this.index=0});

  PostLoaded copyWith(int index) {
    return PostLoaded(posts, index: index);
  }

  @override
  List<Object> get props => [posts,index];
}

final class PostError extends PostState {
  final String message;

  const PostError(this.message);

  @override
  List<Object> get props => [message];
}

final class PostInitial extends PostState {}

final class PostEmpty extends PostState {}

final class PostImageIndexChanged extends PostState {
  final int index;
  const PostImageIndexChanged(this.index);

  @override
  List<Object> get props => [index];
}

final class PostSold extends PostState {
  final PostEntity post;

  const PostSold(this.post);

  @override
  List<Object> get props => [post];
}
