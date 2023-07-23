import 'package:dio/dio.dart';

abstract interface class API {
  Future<Response<T>> httpGet<T>({
    required String url,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? overrideHeaders,
    Map<String, dynamic> additionalHeaders = const {},
    ResponseType? responseType,
    int? receiveTimeoutInMs,
    int? connectTimeoutInMs,
  });

  Future<Response<T>> httpPost<T>({
    required String url,
    required dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? overrideHeaders,
    Map<String, dynamic> additionalHeaders = const {},
    ResponseType? responseType,
    int? receiveTimeoutInMs,
    int? connectTimeoutInMs,
  });

  Future<Response<dynamic>> httpPut({
    required dynamic data,
    required String url,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? overrideHeaders,
    Map<String, dynamic> additionalHeaders = const {},
    ResponseType? responseType,
    int? receiveTimeoutInMs,
    int? connectTimeoutInMs,
  });

  Future<Response<dynamic>> httpPatch({
    required dynamic data,
    required String url,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? overrideHeaders,
    Map<String, dynamic> additionalHeaders = const {},
    ResponseType? responseType,
    int? receiveTimeoutInMs,
    int? connectTimeoutInMs,
  });

  Future<Response<T>> httpDelete<T>({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? overrideHeaders,
    Map<String, dynamic> additionalHeaders = const {},
    ResponseType? responseType,
    int? receiveTimeoutInMs,
    int? connectTimeoutInMs,
  });

  Future<Response<dynamic>> retry({
    required RequestOptions requestOptions,
    CancelToken? cancelToken,
    ResponseType? responseType,
    int? receiveTimeoutInMs,
    int? connectTimeoutInMs,
  });
}
