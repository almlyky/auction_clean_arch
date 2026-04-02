import 'package:auction_clean_arch/core/constant/app_const.dart';
import 'package:auction_clean_arch/core/network/dio_client.dart';
import 'package:auction_clean_arch/core/network/links_api.dart';
import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/favorite/data/model/favorite_model.dart';
import 'package:dio/dio.dart';

class FavoriteDatasource {
  final DioClient _dioClient;
  FavoriteDatasource(this._dioClient);

  Future<List<FavoriteModel>> getFavorite() async {
    final response = await _dioClient.get(LinksApi.endpointFavorite);
    return (response.data as List)
        .map((json) => FavoriteModel.fromJson(json))
        .toList();
  }

  Future<void> addFavorite({required int postId, required int userId}) async {
    await _dioClient.post(
      endpoint: LinksApi.endpointFavorite,
      data: {AppConst.keyPostId: postId, AppConst.keyUserId: userId},
    );
  }

  Future<void> deleteFavorite(int postId) async {
    await _dioClient.delete("${LinksApi.endpointFavorite}/$postId");
  }
}
