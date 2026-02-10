import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:wassela_task_app/core/theming/styles.dart';
import 'package:wassela_task_app/features/users/data/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;
  final int index;

  const UserCard({
    super.key,
    required this.user,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100).clamp(0, 400)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
          padding: EdgeInsets.all(3.5.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3.w),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.mainColor1.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              // Avatar
              Hero(
                tag: 'user_avatar_${user.id}',
                child: Container(
                  width: 13.w,
                  height: 13.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        ColorsManager.mainColor1.withValues(alpha: 0.15),
                        ColorsManager.mainColor1.withValues(alpha: 0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: user.image ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: Icon(
                          Icons.person,
                          color: ColorsManager.mainColor1,
                          size: 6.w,
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(
                          Icons.person,
                          color: ColorsManager.mainColor1,
                          size: 6.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: TextStyles.font16BlackBold.copyWith(
                        fontSize: 17.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      user.email ?? '',
                      style: TextStyles.font16fontGreyMedium.copyWith(
                        fontSize: 15.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (user.company?.title != null) ...[
                      SizedBox(height: 0.5.h),
                      Row(
                        children: [
                          Icon(
                            Icons.work_outline_rounded,
                            size: 3.5.w,
                            color: ColorsManager.mainColor1.withValues(
                              alpha: 0.7,
                            ),
                          ),
                          SizedBox(width: 1.5.w),
                          Expanded(
                            child: Text(
                              user.company!.title!,
                              style: TextStyles.font16fontGreyMedium.copyWith(
                                fontSize: 14.sp,
                                color: ColorsManager.mainColor1.withValues(
                                  alpha: 0.8,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              // Arrow
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 4.w,
                color: ColorsManager.gray1_2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
