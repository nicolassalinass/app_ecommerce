class ServerException implements Exception {
  final String message;
  ServerException({this.message = "Error en el servidor"});
}

class CacheException implements Exception {
  final String message;
  CacheException({this.message = "Error al acceder a la caché"});
}