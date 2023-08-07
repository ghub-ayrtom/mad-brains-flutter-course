import 'package:flutter/material.dart';
import 'package:lesson_3_homework/components/constants.dart';
import 'package:lesson_3_homework/presentation/home/pages/home_page.dart';

// Метод вызова диалога с ошибкой
void showExceptionDialog({BuildContext? context, required String exception}) {
  // Так как диалог всегда отображается в конкретном контексте, то необходимо
  // либо передать его из определённого окна приложения, либо взять контекст
  // главного экрана приложения по глобальному статическому ключу
  final inContext = context ?? HomePage.globalKey.currentContext;

  if (inContext != null) {
    showDialog(
      context: inContext,
      builder: (_) => ExceptionDialog(exception),
    );
  }
}

// Виджет простого диалога с ошибкой
class ExceptionDialog extends StatelessWidget {
  const ExceptionDialog(this.exception, {Key? key}) : super(key: key);

  final String? exception; // Строка возникшей ошибки

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 275,
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CloseButton(
                    color: Colors.black54,
                  ),
                ],
              ),
              const Icon(
                Icons.error,
                size: 50,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  textAlign: TextAlign.center,
                  '${Local.error} ${exception ?? Local.unknown}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
