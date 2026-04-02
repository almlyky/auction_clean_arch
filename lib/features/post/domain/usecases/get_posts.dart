import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/domain/repo/post_repo.dart';

class GetPosts {
  final PostRepo postRepo;

  GetPosts(this.postRepo);
  Future<Result<List<PostEntity>>> call() async {
    return await postRepo.getPosts();
  }
}
