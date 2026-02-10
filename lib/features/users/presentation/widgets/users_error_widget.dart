import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wassela_task_app/core/helpers/app_texts.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:wassela_task_app/core/theming/styles.dart';
import 'package:wassela_task_app/core/widgets/app_text_button.dart';

class UsersErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const UsersErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: Colors.red.shade400,
                size: 10.w,
              ),
            ),
            SizedBox(height: 2.5.h),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyles.font16BlackMedium.copyWith(
                fontSize: 15.sp,
                color: ColorsManager.gray1,
              ),
            ),
            SizedBox(height: 3.h),
            AppTextButton(
              buttonText: AppTexts.retry,
              horizontalPadding: 0,
              verticalPadding: 0,
              borderRadius: 2,
              buttonWidth: 40,
              buttonHeight: 5.5,
              textStyle: TextStyles.font16WhiteBold,
              backgroundColor: ColorsManager.mainColor1,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
