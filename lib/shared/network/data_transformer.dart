import 'package:either_dart/either.dart';

import '../shared.dart';

typedef BushaExceptionOr<T> = Either<BushaException, T>;
typedef FutureBushaExceptionOr<T> = Future<BushaExceptionOr<T>>;
