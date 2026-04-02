import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("المفضلة"),
      // ),
      body: Column(
        children: [
          // Expanded(
          //   child: BlocBuilder<FavoriteCubit, BaseState<List<FavoriteModel>>>(
          //     builder: (context, state) {
          //       return BaseStateBuilder(
          //         state: state,
          //         onLoaded: (data) {
          //           return ListView.builder(
          //             // shrinkWrap: true,
          //             itemBuilder: (context, index) {
          //               return PostCard(post: data[index].post!);
          //               // Post(data[index].post!.name.toString(),style: TextStyle(color: Colors.red),);
          //             },
          //             itemCount: data.length,
          //           );
          //         },
          //         // onInitial: ,
          //         onRetry: () {
          //           context.read<FavoriteCubit>().getFavorites();
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
