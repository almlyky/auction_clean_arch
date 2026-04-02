import 'package:auction_clean_arch/core/theme/app_colors.dart';
import 'package:auction_clean_arch/features/post/data/models/post_model.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowImages extends StatelessWidget {
  const ShowImages({super.key, required this.context, required this.post});

  final BuildContext context;
  @override
  Widget? get leading => null;

  @override
  Widget build(BuildContext context) {
    context.read<PostCubit>().changeImageIndex(0);
    return
    // expandedHeight: 300,
    // pinned: true,
    // backgroundColor: AppColors.primary,
    // leading: Container(
    //   margin: const EdgeInsets.all(8),
    //   decoration: BoxDecoration(
    //     color: Colors.black26,
    //     shape: BoxShape.circle,
    //   ),
    //   child: IconButton(
    //     icon: const Icon(Icons.arrow_back, color: Colors.white),
    //     onPressed: () => Navigator.pop(context),
    //   ),
    // ),
    //  flexibleSpace: FlexibleSpaceBar(
    SizedBox(
      height: 300,
      child: Stack(
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
                  // height: 100,
                  post.images![index].imageUrl ?? '',
                  fit: BoxFit.contain,
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
                    int index = 0;
                    if (state is PostLoaded) {
                      // if (state.index != null) {
                      index = state.index;
                      // }
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
    );
  }

  final PostEntity post;
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
        
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: PageView.builder(
                onPageChanged: (index) {
                  context.read<PostCubit>().changeImageIndex(index);
                },
                itemCount: post.images?.length ?? 0,
                controller: PageController(initialPage: initialIndex),
                itemBuilder: (context, index) {
                  initialIndex = index;
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
            SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 4,
                    child: ListView.separated(
                      
                      separatorBuilder: (context, index) => SizedBox(width: 4),
                      scrollDirection: Axis.horizontal,
                      itemCount: post.images!.length,
                      itemBuilder: (context, index) {
                        int stateIndex = 0;
                        if (state is PostLoaded) {
                          // if (state.index != null) {
                          stateIndex = state.index;
                          // }
                        }
              
                        return Container(
                          width: stateIndex == index ? 20 : 10,
                          color: Colors.white,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
  // Widget _buildDotsIndicator(int length) {
  //   return Center(
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: List.generate(length, (index) {
  //         final isActive = initialIndex == index;

  //         return GestureDetector(
  //           onTap: () {
  //             _pageController.animateToPage(
  //               index,
  //               duration: const Duration(milliseconds: 300),
  //               curve: Curves.easeInOut,
  //             );
  //           },
  //           child: AnimatedContainer(
  //             duration: const Duration(milliseconds: 250),
  //             margin: const EdgeInsets.symmetric(horizontal: 4),
  //             width: isActive ? 14 : 8,
  //             height: 8,
  //             decoration: BoxDecoration(
  //               color: isActive ? Colors.white : Colors.white54,
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //           ),
  //         );
  //       }),
  //     ),
  //   );
  // }
}


