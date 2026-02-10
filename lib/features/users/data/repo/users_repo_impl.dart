import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:wassela_task_app/core/helpers/app_texts.dart';
import 'package:wassela_task_app/core/networking/api_error_handler.dart';
import 'package:wassela_task_app/core/networking/empty_response.dart';
import 'package:wassela_task_app/features/users/data/datasource/users_remote_datasource.dart';
import 'package:wassela_task_app/features/users/data/models/user_model.dart';
import 'package:wassela_task_app/features/users/data/models/users_response.dart';
import 'package:wassela_task_app/features/users/domain/repo/users_repo.dart';

class UsersRepoImpl extends UsersRepo {
  final UsersRemoteDatasource usersRemoteDatasource;
  UsersRepoImpl({required this.usersRemoteDatasource});

  @override
  Future<Either<EmptyResponse, UsersResponse>> getAllUsers({
    required int limit,
    required int skip,
  }) async {
    try {
      final result = await usersRemoteDatasource.getAllUsers(
        limit: limit,
        skip: skip,
      );

      if (result.data != null) {
        final usersResponse = UsersResponse.fromJson(result.data);
        return Right(usersResponse);
      } else {
        return Left(EmptyResponse(message: AppTexts.noContent));
      }
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    } on FormatException catch (e) {
      return Left(EmptyResponse(message: e.message));
    }
  }

  @override
  Future<Either<EmptyResponse, UserModel>> getUserDataById(int id) async {
    try {
      final result = await usersRemoteDatasource.getUserDataById(id);

      if (result.data != null) {
        final user = UserModel.fromJson(result.data);
        return Right(user);
      } else {
        return Left(EmptyResponse(message: AppTexts.noContent));
      }
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    } on FormatException catch (e) {
      return Left(EmptyResponse(message: e.message));
    }
  }

  @override
  Future<Either<EmptyResponse, UserModel>> updateUser(
    int id,
    Map<String, dynamic> body,
  ) async {
    try {
      final result = await usersRemoteDatasource.updateUser(id, body);

      if (result.data != null) {
        final user = UserModel.fromJson(result.data);
        return Right(user);
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
