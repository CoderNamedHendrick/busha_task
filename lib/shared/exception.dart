sealed class BushaException implements Exception {
  const BushaException();
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
