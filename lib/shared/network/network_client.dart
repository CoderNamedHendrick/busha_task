import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../exception.dart';
import 'data_transformer.dart';

enum RequestMethod { get, post, put, patch, delete }

final bushaNetworkClientProvider =
    Provider.autoDispose<BushaNetworkClient>((ref) {
  return BushaNetworkClient();
});

class BushaNetworkClient {
  late Dio _dio;

  BushaNetworkClient() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 40),
        receiveTimeout: const Duration(minutes: 2),
      ),
    );
    _dio.interceptors.addAll(
      [
        if (kDebugMode)
          LogInterceptor(
            responseBody: true,
            error: true,
            request: true,
            requestBody: true,
            requestHeader: true,
            responseHeader: true,
          ),
      ],
    );
  }

  FutureBushaExceptionOr<Response> call({
    required String path,
    required RequestMethod method,
    dynamic body = const {},
    Map<String, dynamic> queryParams = const {},
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.call(
      path: path,
      method: method,
      body: body,
      queryParams: queryParams,
      options: options,
      cancelToken: cancelToken,
    );
  }
}

extension CallX on Dio {
  FutureBushaExceptionOr<Response> call({
    required String path,
    required RequestMethod method,
    dynamic body = const {},
    Map<String, dynamic> queryParams = const {},
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await switch (method) {
        RequestMethod.get => get(
            path,
            queryParameters: queryParams,
            options: options,
            cancelToken: cancelToken,
          ),
        RequestMethod.post => post(
            path,
            data: body,
            queryParameters: queryParams,
            options: options,
            cancelToken: cancelToken,
          ),
        RequestMethod.put => put(
            path,
            queryParameters: queryParams,
            data: body,
            options: options,
            cancelToken: cancelToken,
          ),
        RequestMethod.patch => patch(
            path,
            queryParameters: queryParams,
            data: body,
            options: options,
            cancelToken: cancelToken,
          ),
        RequestMethod.delete => delete(
            path,
            queryParameters: queryParams,
            data: body,
            options: options,
            cancelToken: cancelToken,
          ),
      };

      return Right(response);
    } on DioException catch (exception) {
      switch (exception.type) {
        case DioExceptionType.badResponse:
          final error = BushaException.fromErrorResponse(exception.response!);

          return Left(error);
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          return const Left(
            MessageException(
                'Error establishing connection to the server. Please try again'),
          );
        case _:
          return Left(
              MessageException(exception.message ?? 'An error occurred'));
      }
    } on Exception catch (e) {
      return Left(MessageException(e.toString()));
    }
  }
}
