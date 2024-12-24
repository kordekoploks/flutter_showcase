//date
class ServerException implements Exception {
  final String? _message;

  ServerException([this._message]);

  String get message => _message ?? '';
}

class CacheException implements Exception {}


//route
class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}