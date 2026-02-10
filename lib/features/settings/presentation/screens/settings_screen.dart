import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wassela_task_app/core/helpers/app_dialogs.dart';
import 'package:wassela_task_app/core/helpers/app_texts.dart';
import 'package:wassela_task_app/core/helpers/extensions.dart';
import 'package:wassela_task_app/core/helpers/spacing.dart';
import 'package:wassela_task_app/core/routing/routes.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:wassela_task_app/core/theming/styles.dart';
import 'package:wassela_task_app/features/auth/presentation/logic/auth_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        title: Text(AppTexts.settings, style: TextStyles.font18BlackBold),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        child: Column(
          children: [
            // Language Tile
            _buildSettingsTile(
              context,
              icon: Icons.language,
              title: AppTexts.language,
              trailing: SizedBox(
                width: 30.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      context.locale.languageCode == 'en'
                          ? 'English'
                          : 'العربية',
                      style: TextStyles.font14GreyRegular.copyWith(
                        color: ColorsManager.mainColor1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: ColorsManager.gray1,
                    ),
                  ],
                ),
              ),
              onTap: () {
                _showLanguageBottomSheet(context);
              },
            ),
            SizedBox(height: 2.h),
            // Logout Tile
            _buildSettingsTile(
              context,
              icon: Icons.logout,
              title: AppTexts.logOut,
              textColor: Colors.red,
              iconColor: Colors.red,
              onTap: () {
                AppDialogs.showQuestionnaireDialog(
                  context,
                  AppTexts.confirmLogout,
                  () {
                    context.read<AuthCubit>().logOut(context);
                  },
                  yesBtnColor: Colors.red,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
    Color? textColor,
    Color? iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: (iconColor ?? ColorsManager.mainColor1).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor ?? ColorsManager.mainColor1,
            size: 20.sp,
          ),
        ),
        title: Text(
          title,
          style: TextStyles.font16BlackMedium.copyWith(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: trailing,
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppTexts.changeLanguage, style: TextStyles.font18BlackBold),
              SizedBox(height: 3.h),
              _buildLanguageOption(
                context,
                languageCode: 'en',
                countryCode: 'US',
                languageName: 'English',
              ),
              Divider(height: 3.h),
              _buildLanguageOption(
                context,
                languageCode: 'ar',
                countryCode: 'EG',
                languageName: 'العربية',
              ),
              verticalSpace( 2),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String languageCode,
    required String countryCode,
    required String languageName,
  }) {
    final isSelected =
        context.locale.languageCode == languageCode &&
        context.locale.countryCode == countryCode;
    return InkWell(
      onTap: () async {
        if (!isSelected) {
          await context.setLocale(Locale(languageCode, countryCode));
          if (context.mounted) {
            context.pushNamedAndRemoveUntil(
              Routes.allUsersScreen,
              predicate: (route) => false,
            );
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          children: [
            Text(
              languageName,
              style: TextStyles.font16BlackMedium.copyWith(
                color: isSelected ? ColorsManager.mainColor1 : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (isSelected) Icon(Icons.check, color: ColorsManager.mainColor1),
          ],
        ),
      ),
    );
  }
}
