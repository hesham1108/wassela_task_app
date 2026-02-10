import 'package:dartz/dartz.dart';
import 'package:wassela_task_app/core/networking/empty_response.dart';
import 'package:wassela_task_app/features/users/data/models/user_model.dart';
import 'package:wassela_task_app/features/users/data/models/users_response.dart';

abstract class UsersRepo {
  Future<Either<EmptyResponse, UsersResponse>> getAllUsers({
    required int limit,
    required int skip,
  });
  Future<Either<EmptyResponse, UserModel>> getUserDataById(int id);
  Future<Either<EmptyResponse, UserModel>> updateUser(
    int id,
    Map<String, dynamic> body,
  );
}
