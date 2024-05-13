import 'package:dio/dio.dart';
import 'package:travel_app/constants/app_url.dart';

import '../service/api_service.dart';

class UserApi {
  final ApiService _apiService = ApiService();

  Future<Response> callCheckUser({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(AppUrl.validateEmail, data: data, options: Options());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callsignUpUser({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.register,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callLoginUser({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.login,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callLoginWithGoogle() async {
    try {
      final Response response = await _apiService.get(
        AppUrl.googleLogin,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callUserData({String? token}) async {
    try {
      final Response response = await _apiService.get(AppUrl.getUserFromToken,
          options: Options(headers: {
            "authorization": "Bearer $token",
          }),
          isShowLoading: false);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callUpLoadItemImage(String filePath) async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: imageName,
        ),
      });
      final Response response = await _apiService.post(
        AppUrl.upLoadImage,
        data: formData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callUpdateProfile({Map<String, dynamic>? data, int? userId}) async {
    try {
      final Response response = await _apiService.patch(
        '${AppUrl.users}/$userId',
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
