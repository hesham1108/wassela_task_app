import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wassela_task_app/core/helpers/extensions.dart';
import 'package:wassela_task_app/core/helpers/local_storage_helper.dart';
import 'package:wassela_task_app/core/routing/routes.dart';
import 'package:wassela_task_app/features/auth/data/models/login_body.dart';
import 'package:wassela_task_app/features/auth/data/models/login_response.dart';
import 'package:wassela_task_app/features/auth/data/repo/auth_repo_impl.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepoImpl authRepoImpl;
  final LocalStorageHelper storage;
  AuthCubit({required this.authRepoImpl, required this.storage})
    : super(AuthInitial());

  //login
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();
  final loginObscurePasswordNotifier = ValueNotifier<bool>(true);

  LoginResponse? loginResponse;

  Future<void> checkLoginForm() async {
    if (loginFormKey.currentState!.validate()) {
      await login();
    }
  }

  Future<void> login() async {
    emit(AuthLoading());

    final result = await authRepoImpl.login(
      LoginBody(
        email: emailController.text,
        password: passwordLoginController.text,
      ),
    );
    result.fold(
      (l) => emit(AuthFailure(errorMessage: l.message ?? "", isPop: true)),
      (r) async {
        loginResponse = LoginResponse.fromJson(r);
        if (loginResponse?.accessToken != null &&
            loginResponse!.accessToken!.isNotEmpty) {
          await storage.saveToken(loginResponse!.accessToken!);
        }
        emit(AuthSuccess(authResponse: loginResponse));
      },
    );
  }

  Future<void> logOut(BuildContext context) async {
    await storage.deleteAllSecureData().then((val) {
      context.pushNamedAndRemoveUntil(
        Routes.loginScreen,
        predicate: (predicate) => false,
      );
    });
  }
}
