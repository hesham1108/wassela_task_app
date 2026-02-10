import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wassela_task_app/core/helpers/app_constants.dart';

import '../../../../core/helpers/local_storage.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final LocalStorage localStorage;
  SplashCubit({required this.localStorage}) : super(SplashInitial());

  Future<bool> checkIfUserLogged() async {
    String? token = await localStorage.readSecureData(AppConstants.tokenKey);
    if (token.isEmpty || token == '' || token.contains('No data found!')) {
      return false;
    } else {
      return true;
    }
  }

  
}
