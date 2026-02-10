import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wassela_task_app/core/helpers/app_initialization.dart';
import 'package:wassela_task_app/core/helpers/app_texts.dart';
import 'package:wassela_task_app/core/routing/app_router.dart';
import 'package:wassela_task_app/core/routing/routes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wassela_task_app/core/theming/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (ctx, orientation, screenType) => MaterialApp(
        theme: ThemeData(colorSchemeSeed: ColorsManager.primaryColor),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: AppTexts.appName,
        initialRoute: Routes.splashScreen,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
