import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../theming/colors.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.labelStyle,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
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
    this.initialValue,
    this.onChanged,
  });
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final String? label, initialValue;
  final bool? isObscureText;
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
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      cursorHeight: cursorHeight,
      textAlign: textAlign ?? TextAlign.start,
      inputFormatters: inputFormatters,
      onTapOutside: (pointerDownEvent) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        labelText: label ?? hintText,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 24.sp,
        ),
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 2.h,
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
              borderSide: const BorderSide(
                  color: ColorsManager.blueButtonColor, width: 1.3),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
              borderSide: const BorderSide(
                color: ColorsManager.lightGray,
                width: 1.3,
              ),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
        ),
        hintStyle: hintStyle ??
            Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.black),
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: backgroundColor ?? ColorsManager.moreLightGray,
        labelStyle: labelStyle ??
            Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.black),
      ),
      obscureText: isObscureText ?? false,
      style: inputTextStyle ??
          Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
      validator: validator,
      maxLines: maxLines ?? 1,
      onChanged: onChanged,
    );
  }
}
