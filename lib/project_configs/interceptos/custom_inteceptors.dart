import 'dart:developer';
import 'package:dio/dio.dart';

// Defines a custom interceptor for logging Dio requests, responses, and errors.
class CustomInterceptors extends Interceptor {
  // A simple constructor for the interceptor.
  CustomInterceptors();

  // Overrides the onRequest method to intercept outgoing requests.
  @override
  // This method is called before a request is sent.
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Logs the request method and full path to the console.
    log('REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path}',
        name: 'Dio');
    // Forwards the request to the next handler in the chain.
    return super.onRequest(options, handler);
  }

  // Overrides the onResponse method to intercept successful responses.
  @override
  // This method is called when a response is received successfully.
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Forwards the response to the next handler in the chain.
    return super.onResponse(response, handler);
  }

  // Overrides the onError method to intercept failed requests.
  @override
  // This method is called when an error occurs.
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Forwards the error to the next handler, allowing it to be caught by other parts of the app.
    return super.onError(err, handler);
  }
}
