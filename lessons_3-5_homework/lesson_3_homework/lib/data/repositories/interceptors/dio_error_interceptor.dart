import 'package:dio/dio.dart';
import 'package:lesson_3_homework/components/constants.dart';

// Общий прерыватель ошибок приложения
class ErrorInterceptor extends Interceptor {
  ErrorInterceptor(this.onErrorHandler);

  // Функция обработки ошибок
  final Function(String, String) onErrorHandler;

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // При возникновении ошибки вызываем callback-функцию
    onErrorHandler(
      err.response?.statusCode?.toString() ?? Local.unknown, // code
      err.message ?? Local.unknown, // message
    );

    handler.next(err); // Передаём ошибку в обработчик
  }
}
