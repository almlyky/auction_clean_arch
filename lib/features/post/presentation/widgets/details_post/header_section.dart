import 'package:auction_clean_arch/core/theme/app_colors.dart';
import 'package:auction_clean_arch/features/post/data/models/post_model.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.theme, required this.post});

  final ThemeData theme;
  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.name ?? 'بدون عنوان',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 16,
              color: ColorScheme.of(context).primary,
            ),
            const SizedBox(width: 4),
            Text(
              context.read<PostCubit>().timeAgo(post.createdAt!),
              // post.createdAt.toString().split(' ')[0],
              // style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(width: 16),
            Icon(
              Icons.location_on_outlined,
              size: 16,
              color: ColorScheme.of(context).primary,
            ),
            const SizedBox(width: 4),
            Text(
              post.address ?? 'غير محدد',
              // style: theme.textTheme.bodySmall?,
            ),
          ],
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            Text("حالة المنتج :"),
            SizedBox(width: 6),
            Container(
              // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              // decoration: BoxDecoration(
              //   color: AppColors.primary.withOpacity(0.1),
              //   borderRadius: BorderRadius.circular(20),
              // ),
              child: Text(
                post.productStatus == 'new' ? 'جديد' : 'مستعمل',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  // fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text("السعر :"),
            SizedBox(width: 6),
            Text(
              '${post.price} ر.س',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
