import 'package:dio/dio.dart';
import 'package:wassela_task_app/core/di/dependancy_injection.dart';
import 'package:wassela_task_app/core/helpers/app_initialization.dart';
import 'package:wassela_task_app/core/helpers/local_storage_helper.dart';
import 'package:wassela_task_app/core/networking/api_urls.dart';
import 'package:wassela_task_app/core/routing/routes.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  static Dio? dio;

  ///Private Construct as i don't want to allow creating instance of this class
  DioFactory._();

  static Future<Dio> getDio() async {
    Duration timeOut = const Duration(seconds: 30);
    if (dio == null) {
      dio = Dio();

      dio!
        ..options.baseUrl = ApiUrls.baseUrl
        ..options.headers = {
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json',
        }
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;

      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors
      ?..add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
        ),
      )
      ..add(
        InterceptorsWrapper(
          // onRequest: (options, handler) {
          //   // // Add the access token to the request header
          //   // options.headers['Authorization'] = 'Bearer your_access_token';
          //   // return handler.next(options);
          // },
          onError: (DioException e, handler) async {
            // log(e.requestOptions.uri.toString());

            if (e.response?.statusCode == 401 &&
                !e.requestOptions.uri.toString().contains(ApiUrls.login)) {
              //   String? newAccessToken = await refreshToken();

              //   if (newAccessToken != null && newAccessToken.isNotEmpty) {
              //     // Update the request header with the new access token
              //     e.requestOptions.headers['Authorization'] =
              //         'Bearer $newAccessToken';

              //     // Repeat the request with the updated header
              //     return handler.resolve(await dio!.fetch(e.requestOptions));
              //   } else {
              // If the new access token is null or empty, then logout the user
              await getIt<LocalStorageHelper>().deleteAllSecureData().then(
                (value) => navigatorKey.currentState!.pushNamedAndRemoveUntil(
                  Routes.loginScreen,
                  (route) => false,
                ),
              );
            }

            return handler.next(e);
          },
        ),
      );
  }
}
