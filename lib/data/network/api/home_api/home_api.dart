import 'package:dio/dio.dart';
import 'package:travel_app/constants/app_url.dart';
import 'package:travel_app/data/network/service/api_service.dart';

class HomeApi {
  final ApiService _apiService = ApiService();

  Future<Response> callBanner() async {
    try {
      final Response response = await _apiService.get(
        AppUrl.banner,
        isShowLoading: false,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callCategory() async {
    try {
      final Response response = await _apiService.get(
        AppUrl.category,
        isShowLoading: false,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callPlaces({int? categoryId, String? keyword, bool isLoading = false}) async {
    try {
      final Response response = await _apiService.get(
        '${AppUrl.place}?${categoryId != null ? 'category_id=$categoryId' : ''}${keyword != null ? '&keyword=$keyword' : ''}',
        isShowLoading: isLoading,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callPlaceDetail({int? placeId}) async {
    try {
      final Response response = await _apiService.get(
        '${AppUrl.placeDetail}$placeId',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callTrendingClothItems({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.trendingClothes,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callAllClothItems({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.newClothes,
        data: data,
        isShowLoading: false,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callsearchItem({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.searchItem,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
