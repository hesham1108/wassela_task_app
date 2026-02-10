import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:wassela_task_app/core/helpers/app_texts.dart';
import 'package:wassela_task_app/core/networking/api_error_handler.dart';
import 'package:wassela_task_app/core/networking/empty_response.dart';
import 'package:wassela_task_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:wassela_task_app/features/auth/data/models/login_body.dart';
import 'package:wassela_task_app/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepoImpl({required this.authRemoteDatasource});

  @override
  Future<Either<EmptyResponse, dynamic>> login(
    LoginBody loginBody,
  ) async {
    try {
      final result = await authRemoteDatasource.login(loginBody);

      if (result.data != null) {

        return Right(result.data);
      } else {
        return Left(EmptyResponse(message: AppTexts.noContent));
      }
    } on DioException catch (e) {
    
      return Left(ErrorHandler.handle(e).failure);
    } on FormatException catch (e) {
      return Left(EmptyResponse(message: e.message));
    }
  }

}
