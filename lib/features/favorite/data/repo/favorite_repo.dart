import 'package:auction_clean_arch/core/errors/exceptions.dart';
import 'package:auction_clean_arch/core/errors/failures.dart';
import 'package:auction_clean_arch/core/errors/handle_result_reop.dart';
import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/favorite/data/datasources/favorite_datasource.dart';
import 'package:auction_clean_arch/features/favorite/data/model/favorite_model.dart';

class FavoriteRepo {
  final FavoriteDatasource _favoriteDatasource;
  FavoriteRepo(this._favoriteDatasource);
  Future<Result<List<FavoriteModel>>> getFavorite() {
    return handleResult(
      remoteCall: () => _favoriteDatasource.getFavorite(),
    );
  }

  Future<Result<void>> addFavorite({
    required int postId,
    required int userId,
  }) {
    return handleResultVoid(
      remoteCall: () =>
          _favoriteDatasource.addFavorite(postId: postId, userId: userId),
    );
  }

  Future<Result<void>> deleteFavorite(int postId) {
    return handleResultVoid(remoteCall: () => deleteFavorite(postId));
  }
}
