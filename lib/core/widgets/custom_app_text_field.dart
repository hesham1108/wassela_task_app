import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wassela_task_app/core/helpers/app_texts.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:wassela_task_app/core/theming/styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppTextField extends StatelessWidget {
  const CustomAppTextField({
    super.key,
    this.extraWidget,
    this.labelStyle,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.errorTextStyle,
    this.prefixIcon,
    this.borderRadius,
    this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    this.validator,
    this.maxLines,
    this.keyboard,
    this.label,
    this.inputFormatters,
    this.textAlign,
    this.cursorHeight,
    this.enabled,
    this.disabledBorder,
    this.required = true,
    this.isOptional = false,
    this.enableInteractiveSelection,
    this.onChanged,
    this.obscureTextNotifier,
    this.isObscuredPassword = false,
    this.onTap
  });
  final Widget? extraWidget;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder, disabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle, errorTextStyle;
  final TextStyle? labelStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final String? label;
  final bool? isObscureText, enableInteractiveSelection, enabled;
  final bool required, isObscuredPassword, isOptional;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextInputType? keyboard;
  final double? borderRadius;
  final TextAlign? textAlign;
  final double? cursorHeight;
  final void Function(String)? onChanged;
  final ValueNotifier<bool>? obscureTextNotifier;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 1.5.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label ?? "",
                  style: labelStyle ?? TextStyles.font15BlackBold,
                ),
                if (isOptional)
                  TextSpan(
                    text: "  ( ${AppTexts.optional} )",
                    style: TextStyles.font16fontGreyMedium.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
              ],
            ),
          ),
        // Text(
        //   required ? label! : "$label (${AppTexts.optional})",
        //   style: labelStyle ?? TextStyles.font15BlackBold,
        // ),
        ValueListenableBuilder(
          valueListenable: obscureTextNotifier ?? ValueNotifier<bool>(false),
          builder: (context, isObscured, child) {
            return TextFormField(
              onTap: onTap,
              enabled: enabled,
              cursorHeight: cursorHeight,
              textAlign: textAlign ?? TextAlign.start,
              inputFormatters: inputFormatters,
              onTapOutside: (pointerDownEvent) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              controller: controller,
              keyboardType: keyboard,
              onChanged: onChanged,
              decoration: InputDecoration(
                disabledBorder:
                    disabledBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 2.w),
                      borderSide: const BorderSide(
                        color: ColorsManager.gray1_5,
                        width: 1.3,
                      ),
                    ),
                isDense: true,
                border: InputBorder.none,
                contentPadding:
                    contentPadding ??
                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                focusedBorder:
                    focusedBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 2.w),
                      borderSide: const BorderSide(
                        color: ColorsManager.mainColor1,
                        width: 1.3,
                      ),
                    ),

                enabledBorder:
                    enabledBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 2.w),
                      borderSide: const BorderSide(
                        color: ColorsManager.gray1_5,
                        width: 1.3,
                      ),
                    ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1.3),
                  borderRadius: BorderRadius.circular(borderRadius ?? 4.5.w),
                ),

                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1.3),
                  borderRadius: BorderRadius.circular(borderRadius ?? 4.5.w),
                ),
                hintStyle: hintStyle ?? TextStyles.font16fontGreyMedium,
                hintText: hintText,
                suffixIcon: isObscuredPassword
                    ? IconButton(
                        icon: isObscured
                            ? Icon(Icons.remove_red_eye_outlined)
                            : Icon(Icons.visibility_off_outlined),
                        onPressed: () {
                          if (obscureTextNotifier != null) {
                            obscureTextNotifier!.value = !isObscured;
                          }
                        },
                      )
                    : suffixIcon,
                prefixIcon: prefixIcon,
                filled: true,
                fillColor: backgroundColor ?? Colors.white,
                errorStyle:
                    errorTextStyle ??
                    TextStyles.font16fontGreyMedium.copyWith(color: Colors.red),
              ),
              obscureText: isObscuredPassword
                  ? isObscured
                  : (isObscureText ?? false),
              style: inputTextStyle ?? TextStyles.font16fontGreyBold,
              validator: validator,
              enableInteractiveSelection: enableInteractiveSelection,
              textAlignVertical: TextAlignVertical.center,
              maxLines: maxLines ?? 1,
            );
          },
        ),
        if (extraWidget != null) extraWidget!,
      ],
    );
  }
}
