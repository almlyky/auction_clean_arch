import 'package:auction_clean_arch/core/theme/app_colors.dart';
import 'package:auction_clean_arch/features/post/data/models/post_model.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildSliverAppBar extends StatelessWidget {
  const BuildSliverAppBar({
    super.key,
    required this.context,
    required this.post,
  });

  final BuildContext context;
  @override
  Widget? get leading => null;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppColors.primary,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black26,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          icon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.more_vert, color: Colors.white),
          ),
          onSelected: (value) {
            if (value == 'report') {
              // ضع هنا منطق الإبلاغ
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('إبلاغ'),
                  content: const Text('تم إرسال الإبلاغ بنجاح.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('حسناً'),
                    ),
                  ],
                ),
              );
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<String>(
              value: 'report',
              child: Row(
                children: [
                  Icon(Icons.report, color: Colors.red),
                  SizedBox(width: 8),
                  Text('إبلاغ'),
                ],
              ),
            ),
          ],
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              itemCount: post.images?.length ?? 0,
              onPageChanged: (index) {
                context.read<PostCubit>().changeImageIndex(index);
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showFullScreenImage(context, index, post);
                  },
                  child: Image.network(
                    post.images![index].imageUrl ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            if ((post.images?.length ?? 0) > 0)
              Positioned(
                bottom: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: BlocBuilder<PostCubit, PostState>(
                    builder: (context, state) {
                      int index;
                      if (state is PostImageIndexChanged) {
                        index = state.index;
                      } else {
                        index = 0;
                      }
                      return Text(
                        '${index + 1} / ${post.images!.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  final PostEntity post;

  //   @override
  //   Widget build(BuildContext context) {
  //     return SliverAppBar(
  //       expandedHeight: 300,
  //       pinned: true,
  //       backgroundColor: AppColors.primary,
  //       leading: Container(
  //         margin: const EdgeInsets.all(8),
  //         decoration: BoxDecoration(
  //           color: Colors.black26,
  //           shape: BoxShape.circle,
  //         ),
  //         child: IconButton(
  //           icon: const Icon(Icons.arrow_back, color: Colors.white),
  //           onPressed: () => Navigator.pop(context),
  //         ),
  //       ),
  //       flexibleSpace: FlexibleSpaceBar(
  //         background: Stack(
  //           fit: StackFit.expand,
  //           children: [
  //             PageView.builder(
  //               itemCount: post.images?.length ?? 0,
  //               onPageChanged: (index) {
  //                 context.read<PostCubit>().changeImageIndex(index);
  //               },
  //               itemBuilder: (context, index) {
  //                 return GestureDetector(
  //                   onTap: () {
  //                     _showFullScreenImage(context, index, post);
  //                   },
  //                   child: Image.network(
  //                     post.images![index].imageUrl ?? '',
  //                     fit: BoxFit.cover,
  //                     errorBuilder: (context, error, stackTrace) {
  //                       return Container(
  //                         color: Colors.grey[300],
  //                         child: const Icon(
  //                           Icons.broken_image,
  //                           size: 50,
  //                           color: Colors.grey,
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 );
  //               },
  //             ),
  //             if ((post.images?.length ?? 0) > 0)
  //               Positioned(
  //                 bottom: 16,
  //                 right: 16,
  //                 child: Container(
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 12,
  //                     vertical: 6,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: Colors.black54,
  //                     borderRadius: BorderRadius.circular(20),
  //                   ),
  //                   child: BlocBuilder<PostCubit, PostState>(
  //                     builder: (context, state) {
  //                       int index;
  //                       if (state is PostImageIndexChanged) {
  //                         index = state.index;
  //                       } else {
  //                         index = 0;
  //                       }
  //                       return Text(
  //                         // "",
  //                         '${index + 1} / ${post.images!.length}',
  //                         style: const TextStyle(
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 12,
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
}

void _showFullScreenImage(
  BuildContext context,
  int initialIndex,
  PostEntity post,
) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: PageView.builder(
          itemCount: post.images?.length ?? 0,
          controller: PageController(initialPage: initialIndex),
          itemBuilder: (context, index) {
            return Center(
              child: InteractiveViewer(
                child: Image.network(
                  post.images![index].imageUrl ?? '',
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}
