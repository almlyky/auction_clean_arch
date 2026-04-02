import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/domain/repo/post_repo.dart';

class GetPostsByCategory {
    final PostRepo postRepo;

  GetPostsByCategory(this.postRepo);
  Future<Result<List<PostEntity>>> call(int catId) async {
    return await postRepo.getPostByCategories(cateId:catId,type: "parent");
  }
}