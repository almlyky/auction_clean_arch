import 'package:auction_clean_arch/core/theme/app_colors.dart';
import 'package:auction_clean_arch/features/post/data/models/post_model.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/widgets/details_post/bottom_bar.dart';
import 'package:auction_clean_arch/features/post/presentation/widgets/details_post/build_sliver_appBar.dart';
import 'package:auction_clean_arch/features/post/presentation/widgets/details_post/description_section.dart';
import 'package:auction_clean_arch/features/post/presentation/widgets/details_post/header_section.dart';
import 'package:auction_clean_arch/features/post/presentation/widgets/details_post/seller_section.dart';
import 'package:auction_clean_arch/features/post/presentation/widgets/details_post/show_images.dart';
// import 'package:auction/features/post/presentation/cubit/post_cubit/post_cubit.dart';
// import 'package:auction/view/widget/handl_data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPost extends StatelessWidget {
  final PostEntity post;
  const DetailsPost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    PostCubit postCubit = context.read<PostCubit>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("تفاصيل الاعلان"),
        actions: [
          PopupMenuButton(
            itemBuilder: (contex) => [
              PopupMenuItem<String>(
                padding: EdgeInsets.only(right: 30),

                onTap: () {
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
                },
                value: 'report',
                child: Text('إبلاغ'),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Icon(Icons.report, color: Colors.red),
                //     SizedBox(width: 8),
                //     Text('إبلاغ'),
                //   ],
                // ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          // BuildSliverAppBar(context: context, post: post),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: HeaderSection(theme: theme, post: post),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DescriptionSection(theme: theme, post: post),
          ),
          const SizedBox(height: 16),

          ShowImages(context: context, post: post),
          // const SizedBox(height: 16),
          // SellerSection(theme: theme, isDark: isDark, postCubit: postCubit),
          const SizedBox(height: 100),
        ],
      ),
      bottomSheet: BottomBar(
        theme: theme,
        isDark: isDark,
        post: post,
        postCubit: postCubit,
      ),
    );
  }
}
