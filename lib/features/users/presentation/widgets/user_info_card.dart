import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wassela_task_app/core/helpers/app_texts.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:wassela_task_app/core/theming/styles.dart';
import 'package:wassela_task_app/features/users/data/models/user_model.dart';

class UserInfoCard extends StatelessWidget {
  final UserModel user;

  const UserInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.personalInfo,
              style: TextStyles.font16BlackBold.copyWith(
                fontSize: 16.sp,
                color: ColorsManager.mainColor1,
              ),
            ),
            SizedBox(height: 1.5.h),
            _buildInfoRow(
              Icons.phone_outlined,
              AppTexts.phone,
              user.phone ?? '-',
            ),
            _buildDivider(),
            _buildInfoRow(
              Icons.cake_outlined,
              AppTexts.birthDate,
              user.birthDate ?? '-',
            ),
            _buildDivider(),
            _buildInfoRow(
              Icons.wc_outlined,
              AppTexts.gender,
              user.gender ?? '-',
            ),
            _buildDivider(),
            _buildInfoRow(
              Icons.person_outline,
              AppTexts.username,
              '@${user.username ?? '-'}',
            ),
            if (user.university != null) ...[
              _buildDivider(),
              _buildInfoRow(
                Icons.school_outlined,
                AppTexts.university,
                user.university!,
              ),
            ],
            if (user.company != null) ...[
              _buildDivider(),
              _buildInfoRow(
                Icons.business_outlined,
                AppTexts.company,
                user.company!.name ?? '-',
              ),
              if (user.company!.department != null) ...[
                _buildDivider(),
                _buildInfoRow(
                  Icons.domain_outlined,
                  AppTexts.department,
                  user.company!.department!,
                ),
              ],
            ],
            if (user.address != null) ...[
              _buildDivider(),
              _buildInfoRow(
                Icons.location_on_outlined,
                AppTexts.address,
                '${user.address!.city ?? ''}, ${user.address!.state ?? ''}',
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(1.5.w),
            decoration: BoxDecoration(
              color: ColorsManager.mainColor1.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Icon(icon, size: 4.5.w, color: ColorsManager.mainColor1),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyles.font16fontGreyMedium.copyWith(
                    fontSize: 14.sp,
                    color: ColorsManager.gray1_2,
                  ),
                ),
                SizedBox(height: 0.3.h),
                Text(
                  value,
                  style: TextStyles.font16BlackMedium.copyWith(fontSize: 15.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey.withValues(alpha: 0.12), height: 0.5.h);
  }
}
