import 'package:auction_clean_arch/core/constant/app_const.dart';
import 'package:auction_clean_arch/core/di/dependency_injection.dart';
import 'package:auction_clean_arch/core/errors/exceptions.dart';
import 'package:auction_clean_arch/core/errors/failures.dart';
import 'package:auction_clean_arch/core/services/flutter_secure_storage_services.dart';
import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:auction_clean_arch/features/auth/data/models/response_login_model.dart';
import 'package:auction_clean_arch/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';

class AuthRepository {
  // final FlutterSecureStorageService localDataSource;
  final AuthRemoteDataSource remoteDataSource;
  // final Box<UserModel> userBox;

  AuthRepository({
    required this.remoteDataSource,
    // required this.localDataSource,
    // required this.userBox,
  });

  final _userBox = getIt<Box<UserModel>>();

  Future<Result<ResponseLoginModel>> login({
    required String phone,
    required String password,
  }) async {
    try {
      ResponseLoginModel response = await remoteDataSource.login(
        phone: phone,
        password: password,
      );
      await FlutterSecureStorageService.setToken(response.accessToken);
      await _userBox.put(AppConst.keyUserBox, response.user);

      return Result.success(response);
    } on NetworkException catch (e) {
      return Result.failure(Failure(e.errorModel.errorMessage));
    } on ServerException catch (e) {
      return Result.failure(Failure(e.errorModel.errorMessage));
    } catch (e) {
      return Result.failure(Failure(e.toString()));
    }
  }

  UserModel? getUserFromLocal() {
    return _userBox.get(AppConst.keyUserBox);
  }
}
