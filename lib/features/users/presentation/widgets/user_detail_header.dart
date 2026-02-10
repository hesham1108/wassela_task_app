import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:wassela_task_app/core/theming/styles.dart';
import 'package:wassela_task_app/features/users/data/models/user_model.dart';

class UserDetailHeader extends StatelessWidget {
  final UserModel user;

  const UserDetailHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 3.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.mainColor1,
            ColorsManager.mainColor1.withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(6.w)),
      ),
      child: Column(
        children: [
          Hero(
            tag: 'user_avatar_${user.id}',
            child: Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: user.image ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.white.withValues(alpha: 0.3),
                    child: Icon(Icons.person, color: Colors.white, size: 10.w),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.white.withValues(alpha: 0.3),
                    child: Icon(Icons.person, color: Colors.white, size: 10.w),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 1.5.h),
          Text(
            user.fullName,
            style: TextStyles.font18BlackBold.copyWith(
              color: Colors.white,
              fontSize: 19.sp,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            user.email ?? '',
            style: TextStyles.font16fontGreyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 15.sp,
            ),
          ),
          if (user.company?.title != null) ...[
            SizedBox(height: 0.5.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(5.w),
              ),
              child: Text(
                user.company!.title!,
                style: TextStyles.font16fontGreyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.95),
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
