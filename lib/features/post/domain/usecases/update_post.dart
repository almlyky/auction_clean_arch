import 'dart:io';

import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/domain/repo/post_repo.dart';

class UpdatePost {
  final PostRepo postRepo;

  UpdatePost(this.postRepo);
  Future<Result<PostEntity>> call(int postId,PostEntity data,List<File> images,List<int> deletImageIds) async {
    return await postRepo.updatePost( postId,data,images, deletImageIds);
  }
}