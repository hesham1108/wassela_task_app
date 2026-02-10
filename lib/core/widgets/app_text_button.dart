import 'package:flutter/material.dart';
import 'package:wassela_task_app/core/theming/styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../theming/colors.dart';

class AppTextButton extends StatelessWidget {
  final double? borderRadius;
  final Color? backgroundColor, textColor, borderColor;
  final double horizontalPadding;
  final double verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonText;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  final WidgetStateProperty<BorderSide>? buttonBorder;
  final bool enabled, fitText;
  final Widget? child;
  const AppTextButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    required this.horizontalPadding,
    required this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonText,
    this.textStyle,
    required this.onPressed,
    this.buttonBorder,
    this.enabled = true,
    this.fitText = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        side: buttonBorder,
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular((borderRadius ?? 10).w),
            side: BorderSide(
              color: borderColor ?? ColorsManager.primaryColor,
              width: borderColor != null ? 1 : 0,
            ),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(
          enabled
              ? backgroundColor ?? ColorsManager.primaryColor
              : ColorsManager.gray1_6,
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding.w,
            vertical: verticalPadding.h,
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          Size(buttonWidth?.w ?? double.maxFinite, buttonHeight?.h ?? 7.h),
        ),
      ),
      onPressed: enabled ? onPressed : null,
      child:child != null? child!: fitText
          ? FittedBox(
              child: Text(
                buttonText,
                style:
                    textStyle ??
                    TextStyles.font17WhiteBold.copyWith(color: textColor),
              ),
            )
          : Text(
              buttonText,
              style:
                  textStyle ??
                  TextStyles.font17WhiteBold.copyWith(color: textColor),
            ),
    );
  }
}
