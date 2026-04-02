import 'package:auction_clean_arch/core/di/dependency_injection.dart';
import 'package:auction_clean_arch/core/helpers/snackbar_helper.dart';
import 'package:auction_clean_arch/core/routes/app_routes.dart';
import 'package:auction_clean_arch/core/services/hive_services.dart';
import 'package:auction_clean_arch/core/theme/app_theme.dart';
import 'package:auction_clean_arch/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:auction_clean_arch/features/categories/presentation/cubit/category_cubit.dart';
import 'package:auction_clean_arch/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/add_update_cubit/add_update_post_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_images_cubit/post_images_cubit.dart';
import 'package:auction_clean_arch/features/setting/presentation/cubit/setting_cubit/setting_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_cubit.dart';
import 'package:auction_clean_arch/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HiveServices.initializeHive();
  await setUpDi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SettingCubit>()),
        BlocProvider(create: (context) => getIt<LoginCubit>()),
        BlocProvider(create: (context) => getIt<PostCubit>()),
        BlocProvider(create: (context) => getIt<PostImagesCubit>()),
        BlocProvider(create: (context) => getIt<AddUpdatePostCubit>()),
        BlocProvider(create: (context) => getIt<CategoryCubit>()),
        BlocProvider(create: (context) => getIt<HomeCubit>()),
      ],
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: AppRoutes.router,
            debugShowCheckedModeBanner: false,
            locale: const Locale('ar'),
            builder: (context, child) =>
                Directionality(textDirection: TextDirection.rtl, child: child!),
            theme: state is ThemeChanged && state.themeMode == ThemeMode.dark
                ? AppTheme.darkTheme
                : AppTheme.lightTheme,
            scaffoldMessengerKey: SnackbarHelper.messengerKey,
            // home: Login(),
          );
        },
      ),
    );
  }
}
