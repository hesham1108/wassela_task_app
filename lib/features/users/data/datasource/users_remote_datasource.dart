import 'package:dio/dio.dart';
import 'package:wassela_task_app/core/networking/api_service.dart';
import 'package:wassela_task_app/core/networking/api_urls.dart';

class UsersRemoteDatasource {
  final ApiService apiService;

  const UsersRemoteDatasource({required this.apiService});

  Future<Response> getAllUsers({required int limit, required int skip}) async {
    final Response response = await apiService.get(
      endPoint: ApiUrls.getUsers,
      auth: false,
      params: {'limit': limit, 'skip': skip},
    );
    return response;
  }

  Future<Response> getUserDataById(int id) async {
    final Response response = await apiService.get(
      endPoint: "${ApiUrls.getUsers}/$id",
      auth: false,
    );
    return response;
  }

  Future<Response> updateUser(int id, Map<String, dynamic> body) async {
    final Response response = await apiService.put(
      endPoint: "${ApiUrls.getUsers}/$id",
      data: body,
      auth: false,
    );
    return response;
  }
  }

