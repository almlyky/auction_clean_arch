import 'package:auction_clean_arch/core/di/dependency_injection.dart';
import 'package:auction_clean_arch/core/helpers/snackbar_helper.dart';
import 'package:auction_clean_arch/core/utils/enums.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/add_update_cubit/add_update_post_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/add_update_cubit/add_update_post_state.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/mypost_cubit/mypost_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/widgets/card_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPost extends StatelessWidget {
  const MyPost({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MypostCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('اعلاناتي')),
        body: BlocListener<AddUpdatePostCubit, AddUpdatePostState>(
          listener: (context, state) {
            /// 🔵 ADD
            if (state is AddPostSuccess) {
              context.read<MypostCubit>().addPostToList(state.post);
              // Navigator.pop(context);
            }

            /// 🟡 UPDATE
            if (state is UpdatePostSuccess) {
              context.read<MypostCubit>().updatePostInList(state.post);
              // Navigator.pop(context);
            }

            /// 🔴 DELETE (لو موجود في نفس الصفحة)
            if (state is DeletePostSuccess) {
              context.read<MypostCubit>().removePostFromList(state.postId);
              // Navigator.pop(context);
            }

            /// ❌ ERROR
            if (state is Error) {
              SnackbarHelper.showSnackbar(state.message);
            }
          },
          child: BlocBuilder<MypostCubit, MyPostState>(
            builder: (contex, state) {
              if (state is MyPostLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MyPostError) {
                return Center(
                  child: Column(
                    children: [
                      Text(state.message),
                      IconButton(
                        onPressed: () {
                          contex.read<MypostCubit>().fetchMyPosts();
                        },
                        icon: const Icon(Icons.refresh, size: 35),
                      ),
                    ],
                  ),
                );
              } else if (state is MyPostLoaded) {
                return Posts(
                  mode: PostCardMode.owner,
                  posts: state.posts,

                  // scrollController: scrollController,
                );
              } else if (state is MyPostEmpty) {
                return Center(child: Text('لا توجد اعلانات'));
              } else {
                return Center(
                  child: IconButton(
                    onPressed: () {
                      contex.read<MypostCubit>().fetchMyPosts();
                    },
                    icon: const Icon(Icons.refresh, size: 35),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
