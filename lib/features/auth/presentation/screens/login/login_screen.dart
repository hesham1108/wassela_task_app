import 'package:flutter/material.dart';
import 'package:wassela_task_app/core/helpers/app_texts.dart';
import 'package:wassela_task_app/core/helpers/spacing.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:wassela_task_app/core/theming/styles.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wassela_task_app/features/auth/presentation/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(5),
                // Logo
                Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: ColorsManager.mainColor1.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Icon(
                    Icons.monetization_on_outlined,
                    size: 8.w,
                    color: ColorsManager.mainColor1,
                  ),
                ),
                verticalSpace(1),
                // Welcome Back
                Text(
                  AppTexts.welcomeBack,
                  style: TextStyles.font21BlackBold.copyWith(fontSize: 18.sp),
                ),
                verticalSpace(1),
                // Subtitle
                Text(
                  AppTexts.at,
                  style: TextStyles.font16fontGreyMedium.copyWith(
                    fontSize: 15.sp,
                    color: Colors.grey[600],
                  ),
                ),
                verticalSpace(1),
                // App Name
                Text(
                  AppTexts.appName,
                  style: TextStyles.font21BlackBold.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                verticalSpace(4),
                // Form
                LoginForm(),
                verticalSpace(8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
