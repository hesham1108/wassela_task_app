// import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wassela_task_app/core/di/dependancy_injection.dart';
import 'package:wassela_task_app/core/helpers/app_constants.dart';
import 'package:wassela_task_app/core/helpers/bloc_observer.dart';
import 'package:wassela_task_app/core/helpers/local_storage.dart';
import 'package:wassela_task_app/my_app.dart';

LocalStorage storage = LocalStorage();
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> appInitialization() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await setupGetIt();
  Locale startLocal = const Locale('en', 'US');

  bool containLang = await storage.containKey(AppConstants.langCode);
  if (containLang) {
    String lang = await storage.readSecureData(AppConstants.langCode);
    debugPrint('App language =======> $lang');
    if (lang == 'ar') {
      startLocal = const Locale('ar', 'EG');
    } else {
      startLocal = const Locale('en', 'US');
    }
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'US')],
      path: 'assets/lang',
      startLocale: startLocal,
      useOnlyLangCode: true,
      child: MyApp(),
     
    ),
  );
}
