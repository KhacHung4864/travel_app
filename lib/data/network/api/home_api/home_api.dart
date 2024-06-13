import 'package:dio/dio.dart';
import 'package:travel_app/configs/constants/app_url.dart';
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

  Future<Response> callListTrip({double? longitude, double? latitude, int? id, bool isLoading = false}) async {
    try {
      final Response response = await _apiService.get(
        'https://go-server-ikbn.onrender.com/api/app/trip?${longitude != null ? 'longitude=$longitude' : ''}${latitude != null ? '&latitude=$latitude' : ''}',
        isShowLoading: isLoading,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callDeleteTrip({int? tripId}) async {
    try {
      final Response response = await _apiService.delete(
        '${AppUrl.trip}$tripId',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callPlaceTrip({double? longitude, double? latitude, String? keyword, bool isLoading = false}) async {
    try {
      final Response response = await _apiService.get(
        '${AppUrl.placeTrip}?${longitude != null ? 'longitude=$longitude' : ''}${latitude != null ? '&latitude=$latitude' : ''}${keyword != null ? '&keyword=$keyword' : ''}',
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
        isShowLoading: false,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getPlaceComments({int? placeId, bool? isShowdLoading}) async {
    try {
      final Response response = await _apiService.get(
        '${AppUrl.placeDetail}$placeId/comments',
        isShowLoading: isShowdLoading ?? true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callDeleteComment({int? commentId}) async {
    try {
      final Response response = await _apiService.delete(
        '${AppUrl.updateComment}$commentId',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callUpdateComment({int? commentId, Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.patch(
        '${AppUrl.updateComment}$commentId',
        data: data,
        isShowLoading: false,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callCreateComment({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.updateComment,
        data: data,
        isShowLoading: false,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callCreateTrip({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.trip,
        data: data,
        isShowLoading: true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callUpdateTrip({int? tripId, Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.patch(
        '${AppUrl.trip}$tripId',
        data: data,
        isShowLoading: true,
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
