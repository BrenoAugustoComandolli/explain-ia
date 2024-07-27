import 'package:dio/dio.dart';

class ApiRepository {
  ApiRepository(this._dio) {
    _dio.options.baseUrl = 'https://viacep.com.br/';
  }

  final Dio _dio;

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> put(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> delete(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.delete(path, data: data);
    } catch (e) {
      rethrow;
    }
  }
}
