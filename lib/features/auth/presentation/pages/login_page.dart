import 'package:auction_clean_arch/core/di/dependency_injection.dart';
import 'package:auction_clean_arch/core/utils/utils.dart';
import 'package:auction_clean_arch/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:auction_clean_arch/features/auth/presentation/widgets/costomtextfiald.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is LoginSuccess) {
                // Navigate to existing Home or Dashboard
                // context.go('/home'); // Assuming GoRouter setup
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Welcome ${state.usermodel.user.name}"),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: widget.formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 70),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 60),
                        child: Text(
                          "تسجيل الدخول",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        "مرحباً بك مجدداً",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 60),
                    CustomTextField(
                      valid: (val) {
                        return Utils.validateFormField(val);
                      },
                      typeinput: TextInputType.emailAddress,
                      controller: widget.phoneController,
                      hint: "الهاتف",
                      icon: Icons.person,
                      checkpass: false,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      valid: (val) {
                        return Utils.validateFormField(val);
                      },
                      typeinput: TextInputType.text,
                      controller: widget.passwordController,
                      hint: "كلمة المرور",
                      icon: Icons.lock_open_outlined,
                      checkpass: true,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: TextButton(
                        onPressed: () {
                          // Forgot password logic
                        },
                        child: const Text(
                          "هل نسيت كلمة المرور؟",
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: state is LoginLoading
                          ? null
                          : () {
                              if (widget.formKey.currentState!.validate()) {
                                context.read<LoginCubit>().login(
                                  phone: widget.phoneController.text,
                                  password: widget.passwordController.text,
                                );
                              }
                            },
                      child: state is LoginLoading
                          ? const CircularProgressIndicator()
                          : const Text("تسجيل الدخول"),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("ليس لديك حساب؟"),
                        TextButton(
                          onPressed: () {
                            // Navigate to Signup
                          },
                          child: const Text("إنشاء حساب جديد"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
