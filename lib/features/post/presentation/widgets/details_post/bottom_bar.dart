import 'package:auction_clean_arch/core/theme/app_colors.dart';
// import 'package:auction_clean_arch/features/post/data/models/post_model.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.theme,
    required this.isDark,
    required this.post,
    required this.postCubit,
  });

  final ThemeData theme;
  final bool isDark;
  final PostEntity post;
  final PostCubit postCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Expanded(
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: AppColors.primary,
          //       padding: const EdgeInsets.symmetric(vertical: 16),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //     onPressed: () {},
          //     child: Text(
          //       "تم البيع",
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 3,
            child: ElevatedButton.icon(
              onPressed: () async {
                final phone = postCubit.getUserPhone();
                if (phone.isNotEmpty) {
                  final Uri launchUri = Uri(scheme: 'tel', path: phone);
                  if (await canLaunchUrl(launchUri)) {
                    await launchUrl(launchUri);
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('لا يمكن فتح تطبيق الهاتف'),
                        ),
                      );
                    }
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('رقم الهاتف غير متوفر')),
                    );
                  }
                }
              },
              icon: const Icon(Icons.call, color: Colors.white),
              label: const Text(
                'تواصل الآن',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // BlocBuilder<FavoriteCubit, BaseState<List<FavoriteModel>>>(
          //   builder: (context, state) {
          //     return Expanded(
          //       flex: 1,
          //       child: OutlinedButton(
          //         onPressed: () {
          //           context.read<FavoriteCubit>().onTapFavorite(post);
          //           // PostCubit cubit = context.read<PostCubit>();
          //           // setState(() {
          //           // if (cubit.isFavorite) {
          //           //   cubit.isFavorite = false;
          //           //   cubit.postModel.fav = 0;
          //           //   context.read<FavoriteCubit>().deleteFavorite(post.id!);
          //           // } else {
          //           //   cubit.isFavorite = true;
          //           //  cubit.postModel.fav = 1; // Update local post model
          //           //   context.read<FavoriteCubit>().addFavorite(post.id!);
          //           // }
          //           // });
          //         },
          //         style: OutlinedButton.styleFrom(
          //           padding: const EdgeInsets.symmetric(vertical: 16),
          //           side: BorderSide(
          //               color:
          //                   context.read<FavoriteCubit>().isfavorate[post.id] ==
          //                           1
          //                       ? AppColors.error
          //                       : Colors.grey),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(12),
          //           ),
          //         ),
          //         child: Icon(
          //           context.read<FavoriteCubit>().isfavorate[post.id] == 1
          //               ? Icons.favorite
          //               : Icons.favorite_border,
          //           color:
          //               context.read<FavoriteCubit>().isfavorate[post.id] == 1
          //                   ? AppColors.error
          //                   : Colors.grey,
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
