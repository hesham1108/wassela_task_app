import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wassela_task_app/core/di/dependancy_injection.dart';
import 'package:wassela_task_app/core/routing/routes.dart';
import 'package:wassela_task_app/features/auth/presentation/logic/auth_cubit.dart';
import 'package:wassela_task_app/features/auth/presentation/screens/login/login_screen.dart';
import 'package:wassela_task_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:wassela_task_app/features/splash/presentation/logic/splash_cubit.dart';
import 'package:wassela_task_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:wassela_task_app/features/users/presentation/logic/users_cubit.dart';
import 'package:wassela_task_app/features/users/presentation/screens/all_users_screen.dart';
import 'package:wassela_task_app/features/users/presentation/screens/user_details_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SplashCubit>(),
            child: const SplashScreen(),
          ),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [BlocProvider(create: (context) => getIt<AuthCubit>())],
            child: const LoginScreen(),
          ),
        );
      case Routes.allUsersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<UsersCubit>(),
            child: const AllUsersScreen(),
          ),
        );
      case Routes.userDetailsScreen:
        final userId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<UsersCubit>(),
            child: UserDetailsScreen(userId: userId),
          ),
        );
      case Routes.settingsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const SettingsScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [BlocProvider(create: (context) => getIt<AuthCubit>())],
            child: const LoginScreen(),
          ),
        );
    }
  }
}
