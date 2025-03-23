class ServerException implements Exception {
  final String message;
  ServerException({this.message = 'Server Error'});
}

class NetworkException implements Exception {
  final String message;
  NetworkException({this.message = 'Network Error'});
}

class CacheException implements Exception {
  final String message;
  CacheException({this.message = 'Cache Error'});
}

class UnexpectedException implements Exception {
  final String message;
  UnexpectedException({this.message = 'Unexpected Error'});
}
