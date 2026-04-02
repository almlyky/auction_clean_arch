part of 'post_images_cubit.dart';

@immutable
sealed class PostImagesState extends Equatable {
  @override
  List<Object> get props => []; 
}

final class PostImagesInitial extends PostImagesState {}
final class PostImagesChanged extends PostImagesState{}
final class PostImagesError extends PostImagesState{
  final String message;
  PostImagesError(this.message);
  @override
  List<Object> get props => [message];
}

