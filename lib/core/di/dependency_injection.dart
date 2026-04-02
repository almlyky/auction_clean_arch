import 'package:auction_clean_arch/core/constant/app_const.dart';
import 'package:auction_clean_arch/core/network/dio_client.dart';
import 'package:auction_clean_arch/core/services/flutter_secure_storage_services.dart';
import 'package:auction_clean_arch/core/services/shared_pref_services.dart';
import 'package:auction_clean_arch/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:auction_clean_arch/features/auth/data/models/user_model.dart';
import 'package:auction_clean_arch/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:auction_clean_arch/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:auction_clean_arch/features/categories/data/datasources/category_remote_data_source.dart';
import 'package:auction_clean_arch/features/categories/data/models/category_model.dart';
import 'package:auction_clean_arch/features/categories/data/repositories/category_repository_impl.dart';
import 'package:auction_clean_arch/features/categories/domain/entities/category_entity.dart';
import 'package:auction_clean_arch/features/categories/domain/repositories/category_repository.dart';
import 'package:auction_clean_arch/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:auction_clean_arch/features/categories/presentation/cubit/category_cubit.dart';
import 'package:auction_clean_arch/features/home/data/repo/setting_repo.dart';
import 'package:auction_clean_arch/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/add_post.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/delete_post.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/get_myposts.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/get_posts_by_category.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/mark_post_sold.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/update_post.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/add_update_cubit/add_update_post_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/mypost_cubit/mypost_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_images_cubit/post_images_cubit.dart';
import 'package:auction_clean_arch/features/setting/presentation/cubit/setting_cubit/setting_cubit.dart';
import 'package:auction_clean_arch/features/post/data/datasources/post_remote_data_source_impl.dart';
import 'package:auction_clean_arch/features/post/data/repo/post_repo_impl.dart';
import 'package:auction_clean_arch/features/post/domain/repo/post_repo.dart';
import 'package:auction_clean_arch/features/post/domain/usecases/get_posts.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future setUpDi() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  // API Client
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  // Flutter secure storage
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(),
  );
  // getIt.registerLazySingleton<FlutterSecureStorageService>(
  //   () => FlutterSecureStorageService(getIt()),
  // );

  // shared preferences

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  getIt.registerLazySingleton<SharedPrefServices>(
    () => SharedPrefServices(getIt()),
  );

  // Boxes
  getIt.registerLazySingleton<Box<CategoryEntity>>(
    () => Hive.box<CategoryEntity>(AppConst.keyCategoriesBox),
  );
  getIt.registerLazySingleton<Box<UserModel>>(
    () => Hive.box<UserModel>(AppConst.keyUserBox),
  );

  // loin
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(dioClient: getIt()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      remoteDataSource: getIt(),
      // localDataSource: getIt(),
      // userBox: getIt(),
    ),
  );
  getIt.registerFactory<LoginCubit>(() => LoginCubit(authRepository: getIt()));

  // home
  getIt.registerFactory<HomeCubit>(() => HomeCubit());

  // setting
  getIt.registerLazySingleton<SettingRepo>(
    () => SettingRepo(getIt<SharedPrefServices>()),
  );
  getIt.registerFactory<SettingCubit>(() => SettingCubit(getIt<SettingRepo>()));

  // Register posts
  getIt.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<PostRepo>(() => PostRepoImpl(getIt()));
  // usecase posts
  getIt.registerLazySingleton<GetPosts>(() => GetPosts(getIt()));
  getIt.registerLazySingleton<GetMyposts>(() => GetMyposts(getIt()));

  getIt.registerLazySingleton<GetPostsByCategory>(
    () => GetPostsByCategory(getIt()),
  );
  getIt.registerLazySingleton<AddPost>(() => AddPost(getIt()));
  getIt.registerLazySingleton<UpdatePost>(() => UpdatePost(getIt()));
  getIt.registerLazySingleton<DeletePost>(() => DeletePost(getIt()));
  getIt.registerLazySingleton<MarkPostAsSold>(() => MarkPostAsSold(getIt()));


  getIt.registerFactory<PostCubit>(() => PostCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory<AddUpdatePostCubit>(
    () => AddUpdatePostCubit(getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<PostImagesCubit>(() => PostImagesCubit());
  getIt.registerFactory<MypostCubit>(() => MypostCubit(getIt()));


  // Register categories
  getIt.registerLazySingleton<CategoryRemote>(
    () => CategoryRemoteImpl(getIt()),
  );
  getIt.registerLazySingleton<CategoryRepo>(
    () => CategoryRepoImpl(getIt<CategoryRemote>()),
  );
  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getIt<CategoryRepo>()),
  );
  getIt.registerFactory<CategoryCubit>(
    () => CategoryCubit(getIt<GetCategoriesUseCase>()),
  );
}
