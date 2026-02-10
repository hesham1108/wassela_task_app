import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wassela_task_app/core/helpers/spacing.dart';
import 'package:wassela_task_app/core/theming/colors.dart';

class CustomIconWidget extends StatelessWidget {
  const CustomIconWidget({
    super.key,
    required this.iconName,
    required this.iconTitle,
    required this.action,
  });
  final String iconName;
  final String iconTitle;
  final Function(BuildContext) action;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 18.w,
          height: 10.h,
          decoration: const BoxDecoration(
            color: ColorsManager.darkBlueColor,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () => action(context),
            icon: Image.asset(iconName, height: 3.5.h),
          ),
        ),
        verticalSpace(0.5),
        Text(
          iconTitle,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
