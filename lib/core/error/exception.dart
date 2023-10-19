class ServerException implements Exception {
  final String? msg;
  const ServerException({required this.msg});
}

class CacheException implements Exception {
  final String? msg;
  const CacheException({required this.msg});
}
