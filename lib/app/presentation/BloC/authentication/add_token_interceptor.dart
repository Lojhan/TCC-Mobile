import 'package:dio/dio.dart';

void Function(RequestOptions, RequestInterceptorHandler)? addToken(
  String token,
) {
  return (
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({'Authorization': 'Bearer $token'});
    handler.next(options);
  };
}
