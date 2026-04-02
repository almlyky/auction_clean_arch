// import 'dart:convert';
// import 'dart:developer';

// import 'package:auction_clean_arch/core/network/result.dart';
// import 'package:auction_clean_arch/features/favorite/data/model/favorite_model.dart';
// import 'package:auction_clean_arch/features/favorite/data/repo/favorite_repo.dart';
// import 'package:auction_clean_arch/features/post/data/models/post_model.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'favorite_state.dart';

// class FavoriteCubit extends Cubit<FavoriteState> {
//   final FavoriteRepo _favoriteRepo;
//   Map<int, int> isfavorate = {};

//   FavoriteCubit(this._favoriteRepo) : super(FavoriteInitial());

//   void initFavorites(List<PostModel> posts) {
//     for (var post in posts) {
//       isfavorate[post.id!] = post.fav!;
//     }
//   }

//   void setFavorate(id, value) {
//     isfavorate[id] = value;
//   }

//   void onTapFavorite(PostModel postModel) {
//     // print("is favorite $isfavorate");

//     if (isfavorate[postModel.id] == 0) {
//       setFavorate(postModel.id, 1);
//       addFavorite(postModel.id!);
//       // addFavorite(productID: productModel.prId!);
//     } else {
//       setFavorate(postModel.id, 0);
//       // removeFavorite(productID: productModel.prId!);
//       deleteFavorite(postModel.id!);
//     }
//     // update();
//   }

//   getFavorites() async {
//     // await load(() async {
//     //   int userId = Services.user!.id!;

//     //   final result = await sharedRepository.getdata(
//     //     "${LinksApi.endpointFavorite}/$userId",
//     //   );
//     //   List<FavoriteModel> favorites = (result as List)
//     //       .map((json) => FavoriteModel.fromJson(json))
//     //       .toList();
//     //   return favorites;
//     // });
//     //   emit(FavoriteLoading());
//     //   try {
//     //     final data = await sharedRepository.getdata(LinksApi.endpointFavorite);
//     //     List<FavoriteModel> favorites =
//     //         (data as List).map((json) => FavoriteModel.fromJson(json)).toList();
//     //     emit(FavoriteLoaded(favorites));
//     //   } catch (e) {
//     //     emit(FavoriteError(e.toString()));
//     //   }
//     // }
//   }

//   deleteFavorite(int postId) async {
//     try {
//       // emit(BaseLoading());
//       await sharedRepository.deleteData("${LinksApi.endpointFavorite}/$postId");
//       // Optionally, you can refresh the favorites list after deletion
//       getFavorites();
//       // emit(BaseInitial());
//     } catch (e) {
//       emit(BaseError(e.toString()));
//     }
//   }

//   void addFavorite(int postId) async {
//     emit(FavoriteLoading());
//      await _favoriteRepo
//         .addFavorite();
//     if (result.isSuccess) {
//       emit(FavoriteLoaded(result.data!));
//     } else {
//       emit(FavoriteError(result.failure!.message));
//     }
//   }
// }
