class ServerException implements Exception {}

class InvalidTokenException implements Exception {}

class NoCredentialException implements Exception {}

class ConnectionException implements Exception {}

class NotFoundException implements Exception {}

class WrongCombinationException implements Exception {
  final String message;

  WrongCombinationException(this.message);
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}
