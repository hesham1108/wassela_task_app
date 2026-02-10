import 'package:dartz/dartz.dart';
import 'package:wassela_task_app/core/networking/empty_response.dart';
import 'package:wassela_task_app/features/auth/data/models/login_body.dart';

abstract class AuthRepo {
  Future<Either<EmptyResponse,dynamic>> login(LoginBody loginBody);
 
}
