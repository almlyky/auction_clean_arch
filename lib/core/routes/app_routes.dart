import 'package:auction_clean_arch/core/di/dependency_injection.dart';
import 'package:auction_clean_arch/core/services/flutter_secure_storage_services.dart';
import 'package:auction_clean_arch/core/utils/enums.dart';
import 'package:auction_clean_arch/features/auth/data/models/user_model.dart';
import 'package:auction_clean_arch/features/auth/presentation/pages/login_page.dart';
import 'package:auction_clean_arch/features/home/presentation/pages/home.dart';
import 'package:auction_clean_arch/features/home/presentation/pages/home_bottombart.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/presentation/pages/add_edit_post.dart';
import 'package:auction_clean_arch/features/post/presentation/pages/details_post.dart';
import 'package:auction_clean_arch/features/post/presentation/pages/my_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class AppRoutes {
  static final String addEditPost = "/addEditPost";
  static final String home = "/home";
  static final String login = "/login";
  static final String signup = "/signup";
  static final String index = "/";
  static final String postDetails = "/postdetails";
  static final String myPosts = "/myposts";
  static final userBox = getIt<Box<UserModel>>();

  static final GoRouter router = GoRouter(
    redirect: (context, state) {
      if (state.uri.toString() == index && AppRoutes.userBox.isEmpty ) {
        return login;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: addEditPost,
      builder: (context, state) {
        if (state.extra is Map) {
          final map = state.extra as Map;
          return AddEditPost(

            postAction: map['action'] as PostActionType,
            post: map['post'] as PostEntity,
          );
        }
        PostActionType postAction = state.extra as PostActionType;
        return AddEditPost(postAction: postAction);
      },
      ),
      // GoRoute(path: index, builder: (context, state) => Home()),
      GoRoute(path: login, builder: (context, state) => LoginPage()),
      GoRoute(path: index, builder: (context, state) => BottomBar()),
      // GoRoute(path: signup, builder: (context, state) => Signup()),
      // GoRoute(path: postDetails, builder: (context, state) => Home()),
      GoRoute(
        path: postDetails,
        builder: (context, state) {
          final PostEntity post = state.extra as PostEntity;
          return DetailsPost(post: post);
        },
      ),
      GoRoute(path: myPosts, builder: (context, state) => MyPost()),
      // أضف المزيد من الراوتات هنا إذا لزم الأمر
    ],
  );
}
