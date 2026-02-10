import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wassela_task_app/core/helpers/app_texts.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:wassela_task_app/core/theming/styles.dart';
import 'package:wassela_task_app/core/widgets/app_text_button.dart';
import 'package:wassela_task_app/core/widgets/custom_app_text_field.dart';
import 'package:wassela_task_app/features/users/presentation/logic/users_cubit.dart';

class UserEditForm extends StatelessWidget {
  const UserEditForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UsersCubit>();
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 15 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Form(
          key: cubit.updateUserFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTexts.editUser,
                style: TextStyles.font16BlackBold.copyWith(
                  fontSize: 15.5.sp,
                  color: ColorsManager.mainColor1,
                ),
              ),
              SizedBox(height: 2.h),
              CustomAppTextField(
                controller: cubit.firstNameController,
                label: AppTexts.firstName,
                labelStyle: TextStyles.font15BlackBold.copyWith(
                  fontSize: 14.sp,
                ),
                hintText: AppTexts.enterFirstName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppTexts.enterFirstName;
                  }
                  return null;
                },
              ),
              SizedBox(height: 1.5.h),
              CustomAppTextField(
                controller: cubit.lastNameController,
                label: AppTexts.lastName,
                labelStyle: TextStyles.font15BlackBold.copyWith(
                  fontSize: 14.sp,
                ),
                hintText: AppTexts.enterLastName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppTexts.enterLastName;
                  }
                  return null;
                },
              ),
              SizedBox(height: 1.5.h),
              CustomAppTextField(
                controller: cubit.emailController,
                label: AppTexts.email,
                labelStyle: TextStyles.font15BlackBold.copyWith(
                  fontSize: 14.sp,
                ),
                hintText: AppTexts.enterEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppTexts.enterEmail;
                  }
                  return null;
                },
              ),
              SizedBox(height: 2.5.h),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: AppTextButton(
                      buttonText: AppTexts.cancel,
                      horizontalPadding: 0,
                      verticalPadding: 0,
                      borderRadius: 2,
                      buttonHeight: 5.5,
                      textStyle: TextStyles.font16BlackBold.copyWith(
                        color: ColorsManager.gray1,
                        fontSize: 14.5.sp,
                      ),
                      backgroundColor: Colors.grey.shade200,
                      onPressed: () {
                        cubit.cancelEdit();
                      },
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: AppTextButton(
                      buttonText: AppTexts.save,
                      horizontalPadding: 0,
                      verticalPadding: 0,
                      borderRadius: 2,
                      buttonHeight: 5.5,
                      textStyle: TextStyles.font16WhiteBold.copyWith(
                        fontSize: 14.5.sp,
                      ),
                      backgroundColor: ColorsManager.mainColor1,
                      onPressed: () async {
                        await cubit.checkUpdateUserForm();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
