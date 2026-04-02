import 'dart:ffi';
import 'dart:io';

import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_images_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'post_images_state.dart';

class PostImagesCubit extends Cubit<PostImagesState> {
  PostImagesCubit() : super(PostImagesInitial());

  List<File> _pickerImages = [];
  List<PostImagesEntity> _serverImage = [];
  List<int> deletedImageIds = [];

  List<File> get pickerImages => _pickerImages;
  List<PostImagesEntity> get serverImage => _serverImage;

  void initPostImageData(List<PostImagesEntity> postImageEntity) {
    _serverImage = List.from(postImageEntity);
    emit(PostImagesChanged());
  }

  void selectPostImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      List<XFile> pickedfiles = await picker.pickMultiImage();
      if (pickedfiles.isEmpty) {
        emit(PostImagesError("لم يتم اختيار صورة"));
        return;
      }
      List<File> newImages = [
        ..._pickerImages,
        ...pickedfiles.map((e) => File(e.path)),
      ];
      _pickerImages = newImages;
      emit(PostImagesInitial());
      emit(PostImagesChanged());
    } catch (e) {
      emit(PostImagesError(e.toString()));
    }
  }

  void deleteExistingImage(int index) {
    deletedImageIds.add(_serverImage[index].id!);
    _serverImage.removeAt(index);
    emit(PostImagesInitial());
    emit(PostImagesChanged());
  }

  void deleteNewImage(int index) {
    _pickerImages.removeAt(index);
    emit(PostImagesInitial());
    emit(PostImagesChanged());
  }

  void resetImages() {
    _pickerImages = [];
    _serverImage = [];
    deletedImageIds = [];
    emit(PostImagesInitial());
    emit(PostImagesChanged());
  }
}
