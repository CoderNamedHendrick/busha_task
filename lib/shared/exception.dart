import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

sealed class BushaException implements Exception {
  const BushaException();

  factory BushaException.fromErrorResponse(Response response) {
    final error = response.data;

    if (error is Map<String, dynamic>) {
      return ServerException.fromJson(error);
    }

    return const MessageException('An error occurred');
  }
}

final class EmptyException extends BushaException {
  const EmptyException();

  @override
  String toString() => '';
}

final class MessageException extends BushaException {
  final String exception;

  const MessageException(this.exception);

  @override
  String toString() => exception;
}

final class ServerException extends BushaException {
  final String error;
  final String message;

  const ServerException(this.error, this.message);

  factory ServerException.fromJson(Map<String, dynamic> json) =>
      ServerException(
        json['error'] ?? '',
        json['message'] ?? '',
      );

  @override
  String toString() => message;
}

final class ObjectParseException extends BushaException {
  const ObjectParseException(this.stacktraceInfo);

  final StackTrace? stacktraceInfo;

  void dumpStackTrace() {
    debugPrintStack(stackTrace: stacktraceInfo);
  }

  @override
  String toString() =>
      'We encountered a problem trying to reach the server. We are working to fix it...';
}
