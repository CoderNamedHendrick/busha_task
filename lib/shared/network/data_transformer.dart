import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';

import '../shared.dart';

typedef BushaExceptionOr<T> = Either<BushaException, T>;
typedef FutureBushaExceptionOr<T> = Future<BushaExceptionOr<T>>;

FutureBushaExceptionOr<E> processData<E>(
  E Function(dynamic json) transformer,
  BushaExceptionOr<Response> response,
) async {
  if (response.isLeft) return Left(response.left);

  return await compute(
    (message) => _transformResponse(message, (p0) => transformer(p0)),
    response.right.data,
  );
}

BushaExceptionOr<E> _transformResponse<E>(
    dynamic data, E Function(dynamic) transform) {
  try {
    return Right(transform(data));
  } on TypeError catch (e) {
    return Left(ObjectParseException(e.stackTrace));
  } on Exception catch (e) {
    return Left(MessageException(e.toString()));
  }
}
