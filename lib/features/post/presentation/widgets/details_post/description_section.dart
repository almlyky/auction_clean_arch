import 'package:auction_clean_arch/features/post/data/models/post_model.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({
    super.key,
    required this.theme,
    required this.post,
  });

  final ThemeData theme;
  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'الوصف',
        //   style: theme.textTheme.titleLarge?.copyWith(
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        const SizedBox(height: 8),
        Text(
          post.discribtion ?? 'لا يوجد وصف',
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
