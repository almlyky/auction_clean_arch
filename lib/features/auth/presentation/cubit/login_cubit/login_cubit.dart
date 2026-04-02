import 'package:auction_clean_arch/features/auth/data/models/response_login_model.dart';
import 'package:auction_clean_arch/features/auth/data/models/user_model.dart';
import 'package:auction_clean_arch/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit({required this.authRepository}) : super(LoginInitial());

  Future<void> login({required String phone, required String password}) async {
    // if (!formKey.currentState!.validate()) return;

    emit(LoginLoading());
    final result = await authRepository.login(phone: phone, password: password);
    if (result.isSuccess) {
      emit(LoginSuccess(result.data!));
    } else {
      emit(LoginFailure(result.failure!.message));
    }

    // final result = await loginUseCase(
    //   // LoginParams(
    //   //   phone: phoneController.text,
    //   //   password: passwordController.text,
    //   // ),
    // );

    // result.fold(
    //   (failure) => emit(LoginFailure(failure.message)),
    //   (user) => emit(LoginSuccess(user)),
    // );
  }

  // @override
  // Future<void> close() {
  //   phoneController.dispose();
  //   passwordController.dispose();
  //   return super.close();
  // }
}
