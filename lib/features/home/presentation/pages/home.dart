import 'dart:convert';
import 'dart:math';
// import 'package:auction/cubit/home_cubit/category_cubit/category_cubit.dart';

import 'package:auction_clean_arch/core/helpers/snackbar_helper.dart';
import 'package:auction_clean_arch/core/utils/enums.dart';
import 'package:auction_clean_arch/features/categories/presentation/widget/category_card.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/add_update_cubit/add_update_post_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/add_update_cubit/add_update_post_state.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_images_cubit/post_images_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/widgets/card_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../categories/presentation/cubit/category_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController scrollController;
  bool isVisible = true;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // تحديد ما إذا كان المستخدم يمرر للأسفل
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      print("scrolling down $isVisible");

      // إذا كان مرئياً، اجعله غير مرئي
      if (isVisible) {
        setState(() {
          isVisible = false;
        });
      }
    }
    // تحديد ما إذا كان المستخدم يمرر للأعلى
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      print("scrolling up $isVisible");
      // إذا كان غير مرئي، اجعله مرئيًا
      if (!isVisible) {
        setState(() {
          isVisible = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('الصفحة الرئيسية')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              switchInCurve: Curves.fastEaseInToSlowEaseOut,
              switchOutCurve: Curves.easeOut,
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: isVisible
                  ? Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            // alignLabelWithHint: true,
                            prefixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {},
                            ),
                            suffixIcon: Icon(Icons.filter_list),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            hintText: "ابحث عن إعلان",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        BlocBuilder<CategoryCubit, CategoryState>(
                          builder: (context, state) {
                            if (state is CategoryLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is CategoryFailure) {
                              return Center(
                                child: Column(
                                  children: [
                                    Text(state.message),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<CategoryCubit>()
                                            .getCategories();
                                      },
                                      icon: const Icon(Icons.refresh, size: 35),
                                    ),
                                  ],
                                ),
                              );
                            } else if (state is CategorySuccess) {
                              return Column(
                                children: [
                                  // Parents
                                  Categories(
                                    categories: state.categories,
                                    selectedCategory: state.selectedParent,
                                    typeCategory: TypeCategory.parent,
                                  ),

                                  const SizedBox(height: 10),

                                  // Children تبقى ظاهرة
                                  if (state
                                          .selectedParent
                                          ?.children
                                          ?.isNotEmpty ==
                                      true)
                                    Categories(
                                      categories:
                                          state.selectedParent!.children!,
                                      selectedCategory: state.selectedChild,
                                      typeCategory: TypeCategory.child,
                                    ),
                                ],
                              );

                              // return Categories(categories: state.categories);
                            } else {
                              return Center(
                                child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<CategoryCubit>()
                                        .getCategories();
                                  },
                                  icon: const Icon(Icons.refresh, size: 35),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ) // يظهر
                  : SizedBox.shrink(), // يختفي تمامًا
            ),
            SizedBox(height: 10),
            BlocListener<AddUpdatePostCubit, AddUpdatePostState>(
              listener: (context, state) {
                /// 🔵 ADD
                if (state is AddPostSuccess) {
                  context.read<PostImagesCubit>().resetImages();
                  context.read<PostCubit>().addPostToList(state.post);
                  // Navigator.pop(context);
                }

                /// 🟡 UPDATE
                if (state is UpdatePostSuccess) {
                  context.read<PostImagesCubit>().resetImages();
                  context.read<PostCubit>().updatePostInList(state.post);
                  // Navigator.pop(context);
                }

                /// 🔴 DELETE (لو موجود في نفس الصفحة)
                if (state is DeletePostSuccess) {
                  context.read<PostCubit>().removePostFromList(state.postId);
                  // Navigator.pop(context);
                }

                /// ❌ ERROR
                if (state is Error) {
                  SnackbarHelper.showSnackbar(state.message);
                }
              },
              child: Expanded(
                child: BlocBuilder<PostCubit, PostState>(
                  builder: (contex, state) {
                    if (state is PostLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is PostError) {
                      return Center(
                        child: Column(
                          children: [
                            Text(state.message),
                            IconButton(
                              onPressed: () {
                                contex.read<PostCubit>().fetchPosts();
                              },
                              icon: const Icon(Icons.refresh, size: 35),
                            ),
                          ],
                        ),
                      );
                    } else if (state is PostLoaded) {
                      return Posts(
                        mode: PostCardMode.public,
                        posts: state.posts,
                        scrollController: scrollController,
                      );
                    } else if (state is PostEmpty) {
                      return Center(child: Text('لا توجد اعلانات'));
                    } else {
                      return Center(
                        child: IconButton(
                          onPressed: () {
                            contex.read<PostCubit>().fetchPosts();
                          },
                          icon: const Icon(Icons.refresh, size: 35),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
