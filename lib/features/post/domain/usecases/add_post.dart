import 'dart:io';

import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/domain/repo/post_repo.dart';

class AddPost {
  final PostRepo postRepo;

  AddPost(this.postRepo);
  Future<Result<PostEntity>> call(PostEntity postEntity,List<File> images) async {
    return await postRepo.addPost(postEntity,images);
  }
}