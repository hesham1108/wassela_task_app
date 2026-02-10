import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wassela_task_app/core/helpers/app_texts.dart';
import 'package:wassela_task_app/core/routing/routes.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:wassela_task_app/core/theming/styles.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 1.h,
        left: 5.w,
        right: 5.w,
        bottom: 2.h,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_getGreetingMessage(), style: TextStyles.font14GreyRegular),
              SizedBox(height: 0.5.h),
              Text(
                AppTexts.users,
                style: TextStyles.font20BlackExtraBold.copyWith(
                  color: ColorsManager.mainColor1,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.settingsScreen);
              },
              icon: Icon(
                Icons.settings_outlined,
                color: ColorsManager.mainColor1,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return AppTexts.goodMorning;
    } else if (hour < 17) {
      return AppTexts.goodAfternoon;
    } else {
      return AppTexts.goodEvening;
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(10.h);
}
