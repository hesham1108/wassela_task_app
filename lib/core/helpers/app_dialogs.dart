import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:wassela_task_app/core/helpers/app_texts.dart';
import 'package:wassela_task_app/core/helpers/extensions.dart';
import 'package:wassela_task_app/core/helpers/spacing.dart';
import 'package:wassela_task_app/core/helpers/widget_extensions.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:wassela_task_app/core/theming/font_weight_helper.dart';
import 'package:wassela_task_app/core/theming/styles.dart';
import 'package:wassela_task_app/core/widgets/app_text_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDialogs {
  static Future<bool> showQuestionnaireDialog(
    BuildContext context,
    String message,
    Function yesActionBtn, {
    Color? yesBtnColor,
    Color? noBtnColor,
  }) async {
    bool result = false;
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 4.h,
                      ),
                      width: 90.w,
                      // height: 35.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4.w)),
                      ),
                      child: Column(
                        spacing: 7.h,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            message,
                            textAlign: TextAlign.center,
                            style: TextStyles.font15BlackMedium.copyWith(
                              fontSize: 18.sp,
                              color: ColorsManager.primaryColor,
                              fontWeight: FontWeightHelper.bold,
                            ),
                          ),

                          Row(
                            spacing: 5.w,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AppTextButton(
                                horizontalPadding: 0,
                                verticalPadding: 0,
                                buttonText: AppTexts.yes,
                                backgroundColor: yesBtnColor ?? Colors.red,
                                borderRadius: 2,
                                onPressed: () {
                                  Navigator.pop(context);
                                  yesActionBtn();
                                },
                              ).expand(),
                              AppTextButton(
                                horizontalPadding: 0,
                                verticalPadding: 0,
                                buttonText: AppTexts.no,
                                backgroundColor: noBtnColor ?? Colors.black54,
                                borderRadius: 2,
                                onPressed: () {
                                  Navigator.pop(context);
                                  result = true;
                                },
                              ).expand(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
    );
    return result;
  }

  static void showLoadingWithSentence(
    BuildContext context,
    String sentence, {
    double? width,
    double? height,
    double? radius,
    bool canPop = false,
    double? padding,
  }) {
    showDialog(
      barrierDismissible: canPop,
      context: context,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: PopScope(
          canPop: canPop,
          child: Center(
            child: Container(
              // padding: EdgeInsets.all(padding ?? 2.w),
              width: width ?? 85.w,
              height: height ?? 30.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 3.w),
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  spacing: 4.h,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: ColorsManager.primaryColor,
                    ),
                    // verticalSpace(2),
                    Text(
                      sentence,
                      style: TextStyles.font16WhiteBold.copyWith(
                        color: ColorsManager.primaryColor,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void showLoadingDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return PopScope(
              canPop: false,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.mainColor,
                    ),
                  ),
                ],
              ),
            );
          },
    );
  }

  static void showNewTost({
    required BuildContext context,
    required String msg,
    void Function()? onTap,
    Color? cardColor,
    Color? titleColor,
  }) {
    late DelightToastBar toast;
    toast = DelightToastBar(
      position: DelightSnackbarPosition.top,
      snackbarDuration: const Duration(seconds: 4),
      animationCurve: Curves.easeInOut,
      autoDismiss: true,
      builder: (context) => GestureDetector(
        onHorizontalDragUpdate: (details) {
          // تعطيل السحب الأفقى عن طريق عدم تنفيذ أي إجراء هنا
          toast.remove();
        },
        child: ToastCard(
          color: cardColor,
          onTap: () {
            toast.remove(); // Use remove to dismiss the toast
            if (onTap != null) {
              onTap();
            }
          },
          leading: Icon(Icons.flutter_dash, size: 3.5.w, color: titleColor),
          title: Center(
            child: Text(
              msg,
              style: TextStyles.font16BlackRegular.copyWith(
                fontWeight: FontWeightHelper.extraBold,
                fontSize: 16.sp,
                color: titleColor,
              ),
            ),
          ),
        ),
      ),
    );

    toast.show(context);
  }

  static void showDialogWithImage(
    BuildContext context,
    String sentence, {
    bool canPop = false,
    Widget? image,
    double? width,
    double? height,
    double? padding,
    VoidCallback? onConfirm,
    VoidCallback? onClose,
    bool showActions = false,
    String? confirmText,
    String? cancelText,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => PopScope(
        canPop: canPop,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(padding ?? 5.w),
            width: width ?? 90.w,
            height: height ?? 35.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.w),
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                spacing: 2.h,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image ??
                      const CircularProgressIndicator(
                        color: ColorsManager.primaryColor,
                      ),
                  verticalSpace(2),
                  Text(sentence, style: TextStyles.font17BlackExtraBolder),
                  if (showActions)
                    Row(
                      spacing: 5.w,
                      children: [
                        Expanded(
                          child: AppTextButton(
                            horizontalPadding: 0,
                            verticalPadding: 0.1,
                            buttonText: confirmText ?? AppTexts.confirm,
                            onPressed: onConfirm ?? () {},
                          ),
                        ),
                        Expanded(
                          child: AppTextButton(
                            horizontalPadding: 0,
                            verticalPadding: 0.1,
                            backgroundColor: Colors.white,
                            buttonBorder: WidgetStatePropertyAll(
                              BorderSide(color: ColorsManager.primaryColor),
                            ),
                            textStyle: TextStyles.font17PrimaryBold,
                            buttonText: cancelText ?? AppTexts.cancel,
                            onPressed: onClose ?? () {},
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> showErrorDialogue(
    BuildContext context,
    String message, {
    VoidCallback? onCancel,
  }) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      width: 90.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.w)),
                      ),
                      child: Column(
                        spacing: 1.h,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Icon(
                              Icons.do_not_disturb_alt,
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                          Text(
                            message,
                            textAlign: TextAlign.center,
                            style: TextStyles.font16BlackBold,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: AppTextButton(
                              horizontalPadding: 0,
                              verticalPadding: 0.1,
                              buttonText: AppTexts.cancel,
                              onPressed: () {
                                context.pop();
                                onCancel?.call();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
    );
  }
}
