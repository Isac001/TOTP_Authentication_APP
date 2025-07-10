// import 'dart:developer';
// import 'package:dio/dio.dart';

// class CustomInterceptors extends Interceptor {
//   // Não precisamos mais do SecretRepository aqui

//   CustomInterceptors();
  
//   // O onRequest agora serve apenas para log
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     log('REQUEST[${options.method}] => PATH: ${options.path}', name: 'Dio');
//     return super.onRequest(options, handler);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}', name: 'Dio');
//     return super.onResponse(response, handler);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}', name: 'Dio');
//     return super.onError(err, handler);
//   }
// }

import 'dart:developer';
import 'package:dio/dio.dart';

class CustomInterceptors extends Interceptor {
  // Para este projeto, o interceptor não precisa de dependências.
  CustomInterceptors();
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path}', name: 'Dio');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
      name: 'Dio',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      name: 'Dio',
    );
    // A exceção continua a ser propagada para ser tratada pelo AuthService e pelo BLoC.
    return super.onError(err, handler);
  }
}