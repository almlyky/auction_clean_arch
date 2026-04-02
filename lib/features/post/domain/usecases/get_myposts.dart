import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/domain/repo/post_repo.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/get_posts.dart';

class GetMyposts {
  final PostRepo postRepo;

  GetMyposts(this.postRepo);
  Future<Result<List<PostEntity>>> call(int userId) async {
    return await postRepo.getMyPosts(userId);
  }
}
