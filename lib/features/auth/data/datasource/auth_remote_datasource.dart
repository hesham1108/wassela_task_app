import 'package:dio/dio.dart';
import 'package:wassela_task_app/core/networking/api_service.dart';
import 'package:wassela_task_app/core/networking/api_urls.dart';
import 'package:wassela_task_app/features/auth/data/models/login_body.dart';

class AuthRemoteDatasource {
  final ApiService apiService;

  const AuthRemoteDatasource({required this.apiService});

  Future<Response> login(LoginBody loginBody) async {
    final Response response = await apiService.post(
      endPoint: ApiUrls.loginReqRes,
      auth: false,
      addLang: false,
      isLogin: true,
      data: loginBody.toJson(),
    );

    if (response.statusCode == 200) {
      // ReqRes only returns token, so we mock the user data
      // This ensures the rest of the app (Users Feature) works fine
      response.data = {
        'id': 1, // Mock ID
        'username': 'mock_user',
        'email': loginBody.email,
        'firstName': 'John',
        'lastName': 'Doe',
        'gender': 'male',
        'image': 'https://dummyjson.com/icon/johnq/128',
        'accessToken':
            response.data['token'], // Map ReqRes token to accessToken
        'refreshToken': 'mock_refresh_token',
      };
    }
    return response;
  }
}
