import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:lesson_3_homework/components/locals/locals.dart';

// Общий прерыватель ошибок приложения
class ErrorInterceptor extends Interceptor {
  ErrorInterceptor(this.mainContext, this.onErrorHandler);

  // Контекст главного экрана приложения для обращения через него к объекту
  // словаря текущей локализации
  final BuildContext mainContext;
  // Функция обработки ошибок
  final Function(String, String) onErrorHandler;

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // При возникновении ошибки вызываем callback-функцию
    onErrorHandler(
      // code
      err.response?.statusCode?.toString() ?? mainContext.locale.unknown,
      // message
      err.message ?? mainContext.locale.unknown,
    );

    _sendToCrashlytics(err);
    handler.next(err); // Передаём ошибку в обработчик
  }

  // Метод для формирования и отправки всех отловленных данным прерывателем
  // предупреждений, исключений и ошибок на сервер Firebase Crashlytics
  void _sendToCrashlytics(DioException exception) {
    // Ключи для получения дополнительной информации о возникшей проблеме
    final customKeys = <String, String>{
      'url': exception.requestOptions.uri.host,
      'path': exception.requestOptions.uri.path,
      'response_type': exception.requestOptions.responseType.toString(),
      'query_params': exception.requestOptions.queryParameters.toString(),
    };

    // Присваиваем собственные ключи выше объекту Firebase Crashlytics, чтобы
    // он мог отобразить их в консоли разработчика на сайте Firebase
    for (final key in customKeys.keys) {
      FirebaseCrashlytics.instance.setCustomKey(key, customKeys[key] ?? '-');
    }

    // Передаём все собранные данные о возникшей проблеме в Crashlytics
    FirebaseCrashlytics.instance.recordError(
      exception.message,
      exception.stackTrace,
      printDetails: true,
    );
  }
}
