import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wassela_task_app/core/helpers/app_dialogs.dart';
import 'package:wassela_task_app/core/helpers/app_regex.dart';
// import 'package:wassela_task_app/core/helpers/app_regex.dart';
import 'package:wassela_task_app/core/helpers/app_texts.dart';
import 'package:wassela_task_app/core/helpers/extensions.dart';
import 'package:wassela_task_app/core/helpers/spacing.dart';
import 'package:wassela_task_app/core/routing/routes.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:wassela_task_app/core/theming/styles.dart';
import 'package:wassela_task_app/core/widgets/app_text_button.dart';
import 'package:wassela_task_app/core/widgets/custom_app_text_field.dart';
import 'package:wassela_task_app/features/auth/presentation/logic/auth_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>();
    return Form(
      key: authCubit.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email / Username
          CustomAppTextField(
            controller: authCubit.emailController,
            label: AppTexts.email,
            labelStyle: TextStyles.font15BlackBold,
            hintText: 'e.g. test@test.com',
            suffixIcon: Icon(Icons.person, color: Colors.grey),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.enterEmail;
              } else if (!AppRegex.isEmailValid(value)) {
                return AppTexts.enterValidEmail;
              }
              return null;
            },
          ),
          verticalSpace(2),
          // Password
          CustomAppTextField(
            controller: authCubit.passwordLoginController,
            label: AppTexts.password,
            labelStyle: TextStyles.font15BlackBold,
            hintText: AppTexts.enterPassword,
            required: true,
            isObscuredPassword: true,
            obscureTextNotifier: authCubit.loginObscurePasswordNotifier,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.enterPassword;
              }
              return null;
            },
          ),
          verticalSpace(1),
          verticalSpace(2),
          // Login Button
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                AppDialogs.showLoadingWithSentence(context, AppTexts.signingIn);
              }
              if (state is AuthSuccess) {
                context.pop();
                context.pushNamedAndRemoveUntil(
                  Routes.allUsersScreen,
                  predicate: (route) => false,
                );
              }
              if (state is AuthFailure) {
                context.pop();
                AppDialogs.showErrorDialogue(context, state.errorMessage);
              }
            },
            child: AppTextButton(
              buttonText: AppTexts.logIn,
              horizontalPadding: 0,
              verticalPadding: 0,
              borderRadius: 2,
              textStyle: TextStyles.font16WhiteBold,
              backgroundColor: ColorsManager.mainColor1,
              onPressed: () async {
                await authCubit.checkLoginForm();
              },
            ),
          ),
        ],
      ),
    );
  }
}
