import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wassela_task_app/core/theming/colors.dart';

class UsersLoadingWidget extends StatelessWidget {
  const UsersLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
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
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(radius: 6.5.w, backgroundColor: Colors.grey[300]),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40.w,
                        height: 1.6.h,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 0.8.h),
                      Container(
                        width: 55.w,
                        height: 1.4.h,
                        color: Colors.grey[200],
                      ),
                      SizedBox(height: 0.8.h),
                      Container(
                        width: 30.w,
                        height: 1.2.h,
                        color: Colors.grey[200],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
