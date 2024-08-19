class NetworkResponse {
  NetworkResponse({required this.statusCode, required this.isSuccess, this.responseData, this.errorMessage});

  final int statusCode;
  final bool isSuccess;
  final dynamic responseData;
  String? errorMessage;
}