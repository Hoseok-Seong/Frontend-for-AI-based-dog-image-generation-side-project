import 'package:dio/dio.dart';
import 'package:puppicasso/helper/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.info("REQUEST[${options.method}] => PATH: ${options.path}");
    logger.info("Headers: ${options.headers}");
    logger.info("Request Body: ${options.data}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.info("RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}");
    logger.info("Response Body: ${response.data}");
    super.onResponse(response, handler);
  }
}