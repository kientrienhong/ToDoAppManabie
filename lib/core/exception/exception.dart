class UnexpectedException implements Exception {
  final String message;
  UnexpectedException({
    required this.message,
  });
}

class ExistedNameException implements Exception {}

class LocalException implements Exception {}
