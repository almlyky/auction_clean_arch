import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/post/domain/repo/post_repo.dart';

class MarkPostAsSold {
  final PostRepo postRepo;

  MarkPostAsSold(this.postRepo);
  Future<Result<void>> call(int postId) async {
    return await postRepo.markPostAsSold(postId);
  }
}
