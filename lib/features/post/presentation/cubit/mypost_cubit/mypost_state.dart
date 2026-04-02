part of 'mypost_cubit.dart';

sealed class MyPostState extends Equatable {
  const MyPostState();

  @override
  List<Object> get props => [];
}

final class MypostInitial extends MyPostState {}
class MyPostLoading extends MyPostState {}

final class MyPostLoaded extends MyPostState {
  final List<PostEntity> posts;

 const MyPostLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

final class MyPostError extends MyPostState {
  final String message;

  const MyPostError(this.message);

  @override
  List<Object> get props => [message];
}

final class MyPostInitial extends MyPostState {}
final class MyPostEmpty extends MyPostState {}


