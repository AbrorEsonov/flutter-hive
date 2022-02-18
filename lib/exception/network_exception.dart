class NetworkException implements Exception {
  final int? errorCode;
  final String? errorMessage;

  NetworkException({this.errorCode, this.errorMessage});
}