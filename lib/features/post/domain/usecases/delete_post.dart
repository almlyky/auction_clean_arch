import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/domain/repo/post_repo.dart';

class DeletePost {
  final PostRepo postRepo;

  DeletePost(this.postRepo);
  Future<Result<void>> call(int postId) async {
    return await postRepo.deletePost(postId);
  }
}